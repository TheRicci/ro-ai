# k8s

This folder contains the Kubernetes manifests for the `ro-ai-EKS` project.

`k8s/` is intentionally separate from `infra/`.

- `infra/` creates and manages the Terraform-defined infrastructure and cluster-side resources
- `k8s/` defines what runs inside the cluster

## Structure

- `base/` for reusable manifests
- `overlays/` for environment-specific composition

## Reading Note

These manifests are part of the target platform model for `ro-ai`.

They are useful as real Kubernetes scaffolding, but they should mainly be read as the Kubernetes expression of the architecture shown in this repository.

