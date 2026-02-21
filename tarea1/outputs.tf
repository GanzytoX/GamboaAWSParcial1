output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.web.public_ip
}

output "website_url" {
  description = "URL to access the demo website"
  value       = "http://${aws_instance.web.public_ip}"
}
