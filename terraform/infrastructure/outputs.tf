output "web_ip" {
    value = aws_instance.prod-web.public_ip
    description = "IP on which apache server is running"
}

output "backend_ip" {
    value = aws_instance.prod-backend.public_ip
    description = "Backend IP"
}