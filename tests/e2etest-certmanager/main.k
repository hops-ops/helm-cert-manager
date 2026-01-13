import datetime
import math
import models.io.upbound.dev.meta.v1alpha1 as metav1alpha1
import models.k8s.apimachinery.pkg.apis.meta.v1 as metav1

# ==============================================================================
# E2E Test for CertManager XRD (Kubernetes-only)
#
# This test uses the Helm provider with ClusterProviderConfig which uses
# injected identity (no credentials needed - runs in-cluster).
# ==============================================================================

# Generate unique name using timestamp to avoid CI conflicts
_now = str(int(math.floor(datetime.ticks())))
_test_name = "e2e-certmgr-" + _now

_items = [
    metav1alpha1.E2ETest {
        metadata.name = "certmanager-helm"
        spec = {
            crossplane = {
                version = "2.0.2-up.5"
                autoUpgrade.channel = "None"
            }
            defaultConditions = ["Ready"]
            timeoutSeconds = 600  # 10 minutes - Helm install is fast
            cleanupTimeoutSeconds = 300  # 5 minutes
            skipDelete = False

            # ==============================================================
            # extraResources: Helm ClusterProviderConfig with injected identity
            # ==============================================================
            extraResources = [
                # Helm ClusterProviderConfig - uses in-cluster identity
                {
                    apiVersion = "helm.crossplane.io/v1beta1"
                    kind = "ClusterProviderConfig"
                    metadata.name = "default"
                    spec = {
                        credentials = {
                            source = "InjectedIdentity"
                        }
                    }
                }
            ]

            # ==============================================================
            # manifests: The CertManager XR to test
            # ==============================================================
            manifests = [
                {
                    apiVersion = "helm.hops.ops.com.ai/v1alpha1"
                    kind = "CertManager"
                    metadata = {
                        name = _test_name
                        namespace = "default"
                    }
                    spec = {
                        clusterName = _test_name
                        labels = {
                            "e2etest" = "true"
                            "test-run" = _now
                        }
                        providerConfigRef = {
                            name = "default"
                            kind = "ClusterProviderConfig"
                        }
                        values = {
                            # Minimal resources for E2E test
                            resources = {
                                requests = {
                                    cpu = "10m"
                                    memory = "32Mi"
                                }
                            }
                            webhook = {
                                resources = {
                                    requests = {
                                        cpu = "10m"
                                        memory = "32Mi"
                                    }
                                }
                            }
                            cainjector = {
                                resources = {
                                    requests = {
                                        cpu = "10m"
                                        memory = "32Mi"
                                    }
                                }
                            }
                        }
                    }
                }
            ]
        }
    }
]
items = _items
