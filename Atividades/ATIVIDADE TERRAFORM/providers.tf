# Configurações AWS para se conectar ao LocalStack
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "chave_acesso_mock"
  secret_key                  = "chave_secreta_mock"
  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    sns = "http://localhost:4566"
    sqs = "http://localhost:4566"
    s3  = "http://localhost:4566"
  }
}