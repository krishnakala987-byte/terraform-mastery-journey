output "alb_url" {
  value = "http://${module.alb.alb_dns}"
}

output "environment" {
  value = terraform.workspace
}