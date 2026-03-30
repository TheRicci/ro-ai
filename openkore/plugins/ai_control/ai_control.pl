package OpenKore::Plugins::ai_control;

use strict;
use IO::Socket::INET;
use IO::Select;

use Commands;
use Globals qw(%config);
use Log qw(message warning error);
use Plugins;

my $server;
my $selector;
my %clients;
my $hooks;

Plugins::register('ai_control', 'Local TCP control channel for AI agent', \&on_unload);
$hooks = Plugins::addHooks(
	['start3', \&on_start],
	['mainLoop_post', \&on_loop],
);

sub on_unload {
	Plugins::delHooks($hooks) if $hooks;
	_shutdown();
}

sub on_start {
	return if !$config{aiControl};

	my $host = $config{aiControl_host} || '127.0.0.1';
	my $port = $config{aiControl_port} || 26050;

	$server = IO::Socket::INET->new(
		LocalAddr => $host,
		LocalPort => $port,
		Listen    => 5,
		ReuseAddr => 1,
		Proto     => 'tcp',
	);

	if (!$server) {
		error "[ai_control] failed to bind $host:$port\n";
		return;
	}

	$server->blocking(0);
	$selector = IO::Select->new();
	$selector->add($server);

	message "[ai_control] listening on $host:$port\n", 'connection';
}

sub on_loop {
	return if !$server || !$selector;

	for my $sock ($selector->can_read(0)) {
		if ($sock == $server) {
			_accept_client();
			next;
		}

		_handle_client($sock);
	}
}

sub _accept_client {
	my $client = $server->accept();
	return if !$client;

	$client->blocking(0);
	my $id = fileno($client);
	$clients{$id} = {
		socket => $client,
		buffer => '',
		authed => 0,
	};

	$selector->add($client);
	_write($client, "OK CONNECTED\n");
}

sub _handle_client {
	my ($client) = @_;
	my $id = fileno($client);
	my $entry = $clients{$id};
	return if !$entry;

	my $read = sysread($client, my $data, 4096);
	if (!defined $read) {
		return;
	}
	if ($read == 0) {
		_close_client($client);
		return;
	}

	$entry->{buffer} .= $data;
	if (length($entry->{buffer}) > 65536) {
		_write($client, "ERR line_too_long\n");
		_close_client($client);
		return;
	}

	while ($entry->{buffer} =~ s/^(.*)\n//) {
		my $line = $1;
		$line =~ s/\r$//;
		_handle_line($client, $entry, $line);
	}
}

sub _handle_line {
	my ($client, $entry, $line) = @_;
	$line =~ s/^\s+//;
	$line =~ s/\s+$//;
	return if $line eq '';

	my $token = $config{aiControl_token};
	if ($token && !$entry->{authed}) {
		if ($line =~ /^AUTH\s+(.+)$/) {
			if ($1 eq $token) {
				$entry->{authed} = 1;
				_write($client, "OK AUTH\n");
				return;
			}
			_write($client, "ERR AUTH\n");
			_close_client($client);
			return;
		}

		_write($client, "ERR AUTH_REQUIRED\n");
		_close_client($client);
		return;
	}

	if ($line eq 'PING') {
		_write($client, "PONG\n");
		return;
	}

	if ($line eq 'QUIT') {
		_write($client, "OK BYE\n");
		_close_client($client);
		return;
	}

	my $ok = eval { Commands::run($line); 1; };
	if (!$ok) {
		warning "[ai_control] command failed: $line\n";
		_write($client, "ERR COMMAND\n");
		return;
	}

	_write($client, "OK\n");
}

sub _write {
	my ($client, $msg) = @_;
	eval { print $client $msg; 1; };
}

sub _close_client {
	my ($client) = @_;
	my $id = fileno($client);

	$selector->remove($client) if $selector;
	delete $clients{$id};
	eval { close $client; 1; };
}

sub _shutdown {
	for my $id (keys %clients) {
		my $client = $clients{$id}{socket};
		_close_client($client) if $client;
	}

	if ($server) {
		$selector->remove($server) if $selector;
		eval { close $server; 1; };
	}

	$server = undef;
	$selector = undef;
	%clients = ();
}

1;
