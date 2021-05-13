output "inventory" {
  value = "${data.template_file.inventory.rendered}"
}

output "default_tags" {
  value = "${var.default_tags}"
}
