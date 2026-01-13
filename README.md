# helm-cert-manager

A Crossplane Configuration package that installs the cert-manager Helm chart with a minimal, stable interface.

## Overview

`helm-cert-manager` renders a single Helm release for cert-manager. It exposes only the inputs needed
for chart values, namespace, and release name, keeping the interface stable while allowing full Helm overrides.

## Features

- **Minimal Helm interface**: values and overrideAllValues with stable defaults
- **Predictable naming**: defaults to `<clusterName>-cert-manager` in the `cert-manager` namespace
- **GitOps friendly**: ships a `.gitops/` deploy chart

## Prerequisites

- Crossplane installed in the cluster
- Crossplane providers:
  - `provider-helm` (>=v1.0.2)
- Crossplane function:
  - `function-auto-ready` (>=v0.6.0)

## Quick Start

```yaml
apiVersion: pkg.crossplane.io/v1
kind: Configuration
metadata:
  name: helm-cert-manager
spec:
  package: ghcr.io/hops-ops/helm-cert-manager:latest
```

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: CertManager
metadata:
  name: cert-manager
  namespace: example-env
spec:
  clusterName: example-cluster
  values:
    prometheus:
      enabled: false
```

## Development

```bash
make render
make validate
make test
```
