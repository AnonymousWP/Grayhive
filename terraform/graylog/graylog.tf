terraform {
  required_providers {
    graylog = {
      source  = "zahiar/graylog"
      version = "1.3.0"
    }
  }
}

provider "graylog" {
  web_endpoint_uri = ""
  api_version      = "v5"
  auth_name        = var.authusername
  auth_password    = var.authpassword
}
