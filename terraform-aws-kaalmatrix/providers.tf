provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project     = "KaalMatrix"
      Environment = var.environment
      Owner       = var.owner
    }
  }
}
provider "http" {}
