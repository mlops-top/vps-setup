variable "OP_TOKEN_VALUE" {
  type        = string
}

variable "OP_ACCOUNT_ID" {
  type        = string
}

terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }
}

provider "cloudflare" {
  api_token = var.OP_TOKEN_VALUE
}

resource "cloudflare_r2_bucket" "cloudflare-bucket" {
  account_id = var.OP_ACCOUNT_ID
  name       = "vps"
  location   = "EEUR"
}
