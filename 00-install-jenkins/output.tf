output "jenkins_public_ip" {
  description = "IP of jenkins server"
  value       = module.compute.public_ip
}