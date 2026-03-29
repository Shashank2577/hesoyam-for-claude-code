# Stack: Kubernetes Platform Engineering

> ECC configuration for Helm, ArgoCD, Crossplane, and platform engineering workflows.

## CLAUDE.md

```markdown
# Project: [Name]

## Platform
- Kubernetes (EKS/AKS/GKE)
- Helm charts for application packaging
- ArgoCD for GitOps deployment
- Crossplane for infrastructure as code
- Kustomize for environment overlays

## Conventions
- All resources namespaced (no cluster-scope unless platform-level)
- Helm values follow: base → environment overlay → secret injection
- Labels: app.kubernetes.io/* standard labels on all resources
- Resource limits required on all containers
- NetworkPolicies default-deny, explicit allow

## Security
- Pod Security Standards: restricted profile
- No privileged containers
- Read-only root filesystem where possible
- Service accounts with minimal RBAC
- Secrets via External Secrets Operator (not raw k8s secrets)

## Commands
- Validate: `helm template . | kubectl apply --dry-run=client -f -`
- Diff: `argocd app diff [app-name]`
- Sync: `argocd app sync [app-name]`
- Logs: `kubectl logs -f deploy/[name] -n [namespace]`
```

## Recommended ECC Agents

- `architect.md` — Platform architecture decisions
- `security-reviewer.md` — K8s security best practices, RBAC audit
- `code-reviewer.md` — YAML/Helm template review

## Key Skills

- Helm chart linting and best practices
- Kubernetes manifest validation
- ArgoCD sync wave ordering
- Crossplane composition patterns
