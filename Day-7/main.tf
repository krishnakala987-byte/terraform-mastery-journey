resource "null_resource" "example" {
  provisioner "local-exec" {
    command = "echo DB Username is ${data.vault_kv_secret_v2.app.data["db_username"]}"
  }
}
