output "password" {
  value = aws_iam_user_login_profile.login_profile.encrypted_password
}

output "secret" {
  value = aws_iam_access_key.lb.encrypted_secret
}
