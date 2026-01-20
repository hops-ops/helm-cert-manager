### What's changed in v0.6.1

* chore(deps): update unbounded-tech/workflow-vnext-tag action to v1.21.0 (#5) (by @renovate[bot])

  Co-authored-by: renovate[bot] <29139614+renovate[bot]@users.noreply.github.com>

* fix: update e2e test to use Rapid channel and typed model (by @patrickleet)

  - Use autoUpgrade.channel = "Rapid" instead of pinning version
  - Use typed helmv1alpha1.CertManager model for manifest
  - Add defaultConditions, timeoutSeconds, cleanupTimeoutSeconds
  - Remove custom values, rely on chart defaults

  Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>

* fix: grant cluster-admin to crossplane-system SAs in e2e test (by @patrickleet)

  The Helm provider with InjectedIdentity uses its own SA which doesn't
  have permission to create namespaces. Grant cluster-admin to all SAs
  in crossplane-system namespace via ClusterRoleBinding.

  Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>


See full diff: [v0.6.0...v0.6.1](https://github.com/hops-ops/helm-cert-manager/compare/v0.6.0...v0.6.1)
