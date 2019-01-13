locals {
    this_public_ip = "${compact(concat(coalescelist(aws_instance.example.*.public_ip, aws_instance.example.*.public_ip), list("")))}"
    this_elb_dns = "${compact(concat(coalescelist(aws_elb.goserverelb.*.dns_name, aws_elb.goserverelb.*.dns_name), list("")))}"
}

output "public_ip" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${local.this_public_ip}"]
}

output "dns_name" {
  description = "List of public IP addresses assigned to the instances, if applicable"
  value       = ["${local.this_elb_dns}"]
}