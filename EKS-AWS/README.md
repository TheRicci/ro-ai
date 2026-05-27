# ro-ai-EKS

`ro-ai-EKS` is a learning repository that uses the `ro-ai` architecture to
teach how Amazon EKS, Terraform, and Kubernetes fit together.

It models the platform with:

- Terraform for platform provisioning
- Kubernetes manifests for workload definitions

## What this repo contains

The current repository is organized around three platform planes:

- world plane: `rAthena` login, char, and map services
- intelligence plane: planner, model gateway, and admin API services
- execution plane: bot runtime workloads

Those workloads are supported by AWS-side building blocks such as:

- VPC, subnets, routing, and DB security group
- EKS cluster and managed node group
- EKS add-ons including CoreDNS, kube-proxy, VPC CNI, and Pod Identity Agent
- workload IAM roles and pod identity associations
- DynamoDB for bot memory
- S3 for bot artifacts
- MariaDB on RDS for world data
- Secrets Manager integration through the Secrets Store CSI Driver pattern

The development root still includes realistic Terraform modules and helper
scripts so you can see how an EKS/Terraform repository is shaped, even if you
never apply it to a real AWS account.

## Repo layout

- `infra/`: Terraform environment roots and reusable modules
- `k8s/`: Kubernetes base manifests and environment overlays

The main design rule is:

- Terraform provisions infrastructure and cluster-side AWS resources
- Kubernetes manifests define what runs inside the cluster  


The best files to read together are:

- `infra/envs/dev/main.tf`
- `infra/envs/dev/variables.tf`
- `infra/envs/dev/terraform.tfvars.example`

That combination shows how the root wires networking, EKS, add-ons, workload  
identity, and data services into one learning-focused Terraform layout.

## Kubernetes layer

The Kubernetes side is split into reusable base manifests plus a development overlay:

- `k8s/base/`: namespaces, service accounts, secret-provider wiring, and shared workload manifests
- `k8s/overlays/dev/`: development-specific replica counts, image tags, AWS region values, and secret name patches

You can render the dev overlay locally with:

```powershell
kubectl kustomize .\k8s\overlays\dev
```

