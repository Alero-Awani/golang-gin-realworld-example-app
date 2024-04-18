output "private_key" {
  value     = tls_private_key.tls_key.private_key_pem
  sensitive = true
}