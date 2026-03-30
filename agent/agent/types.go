package agent

type Personality struct {
	Aggression float32
	Greed      float32
	Social     float32
	Risk       float32
}

type Memory struct {
	LastParty string
	LastDeath string
	Enemies   []string
}

type GameState struct {
	Level     int
	Class     string
	Map       string
	Zeny      int
	HPPercent float32
}

type Decision string

const (
	DecisionGrind Decision = "GRIND"
	DecisionSell  Decision = "SELL"
	DecisionMove  Decision = "MOVE"
	DecisionRest  Decision = "REST"
	DecisionChat  Decision = "CHAT"
)

func (d Decision) Valid() bool {
	switch d {
	case DecisionGrind, DecisionSell, DecisionMove, DecisionRest, DecisionChat:
		return true
	default:
		return false
	}
}

type DecisionInput struct {
	Personality Personality
	Memory      Memory
	State       GameState
}
