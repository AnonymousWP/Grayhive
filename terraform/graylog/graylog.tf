terraform {
  required_providers {
    graylog = {
      source  = "terraform-provider-graylog/graylog"
      version = "1.0.4"
    }
  }
}

provider "graylog" {
  web_endpoint_uri = ""
  api_version      = "v3"
  auth_name        = var.authusername
  auth_password    = var.authpassword
}
