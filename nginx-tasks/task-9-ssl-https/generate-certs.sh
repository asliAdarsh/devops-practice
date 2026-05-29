#!/bin/bash
# ===========================================
# Self-Signed SSL Certificate Generator
# ===========================================
# This script generates a self-signed certificate
# for development/testing purposes.
#
# For production, use Let's Encrypt instead:
#   https://certbot.eff.org/

echo "========================================="
echo "  Generating Self-Signed SSL Certificate"
echo "========================================="

# Create certs directory if it doesn't exist
mkdir -p "$(dirname "$0")/certs"

# Generate a private key and self-signed certificate
# -x509: Generate a self-signed certificate
# -nodes: No password (for non-interactive use)
# -days: Certificate validity period
# -newkey rsa:2048: Generate 2048-bit RSA key
# -keyout: Output file for private key
# -out: Output file for certificate
# -subj: Certificate subject (change as needed)

openssl req -x509 \
  -nodes \
  -days 365 \
  -newkey rsa:2048 \
  -keyout "$(dirname "$0")/certs/nginx-selfsigned.key" \
  -out "$(dirname "$0")/certs/nginx-selfsigned.crt" \
  -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost" \
  -addext "subjectAltName = DNS:localhost, IP:127.0.0.1"

echo ""
echo "========================================="
echo "  Certificate Generated Successfully!"
echo "========================================="
echo ""
echo "Files created:"
echo "  - certs/nginx-selfsigned.crt (Certificate)"
echo "  - certs/nginx-selfsigned.key (Private Key)"
echo ""
echo "To verify the certificate:"
echo "  openssl x509 -in certs/nginx-selfsigned.crt -text -noout"
echo ""
echo "IMPORTANT: For production, use Let's Encrypt!"
echo "========================================="
