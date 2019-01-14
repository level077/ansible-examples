#!/bin/sh
cd /root/ssl/{{ kubernetes_cluster_name }}

TOKEN_ID=$(head -c 6 /dev/urandom | md5sum | head -c 6)
TOKEN_SECRET=$(head -c 16 /dev/urandom | md5sum | head -c 16)

cat > bootstrap.token << EOF
${TOKEN_ID}.${TOKEN_SECRET}
EOF

cat > bootstrap_token_secret.yaml << EOF
apiVersion: v1
kind: Secret
metadata:
  # Name MUST be of form "bootstrap-token-<token id>"
  name: bootstrap-token-${TOKEN_ID}
  namespace: kube-system

# Type MUST be 'bootstrap.kubernetes.io/token'
type: bootstrap.kubernetes.io/token
stringData:
  # Human readable description. Optional.
  description: "The default bootstrap token generated by 'kubeadm init'."

  # Token ID and secret. Required.
  token-id: ${TOKEN_ID}
  token-secret: ${TOKEN_SECRET}

  # Expiration. Optional.
  #expiration: 2018-09-10T00:00:11Z

  # Allowed usages.
  usage-bootstrap-authentication: "true"
  usage-bootstrap-signing: "true"

  # Extra groups to authenticate the token as. Must start with "system:bootstrappers:"
  auth-extra-groups: system:bootstrappers:worker,system:bootstrappers:ingress
EOF
