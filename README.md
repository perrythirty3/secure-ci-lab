# secure-ci-lab

[![secure-ci](https://github.com/${OWNER}/${REPO}/actions/workflows/secure-ci.yml/badge.svg)](../../actions/workflows/secure-ci.yml)
![Schedule](https://img.shields.io/badge/schedule-hourly-blue)


A tiny lab that demonstrates **secure CI/CD**:
- IaC scanning with **Checkov**
- App + container scanning with **Trivy**
- Images pushed to **GHCR** only if scans pass
- (Optional) OIDC → AWS + Secrets Manager
- (Optional) k3d + Kyverno policy demo

## Quick start
- Open a PR → Checkov + Trivy run; PR must pass to merge.
- On push to `main`, image builds, scans, and pushes to GHCR.

## k8s demo (optional)
- `k3d cluster create labby`
- `kubectl apply -f k8s/`
# Tiny change to trigger CI
<<<<<<< HEAD

# force trigger
=======
>>>>>>> 68b777c (chore: trigger CI from feature branch)
