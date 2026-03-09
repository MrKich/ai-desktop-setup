terraform {
  required_version = ">=1.13"

  required_providers {
    http = {
      source = "hashicorp/http"
      version = "~> 3.5"
    }

    openwebui = {
      source  = "ncecere/openwebui"
      version = "~> 2.7"
    }
  }
}
