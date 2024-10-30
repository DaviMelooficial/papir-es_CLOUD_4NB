# Lista de strings para os nomes dos buckets
variable "nomes_buckets_s3" {
  type    = list(string)
  default = ["local-files", "bronze", "silver", "gold"]
}

# Nome do tópico SNS
variable "nome_topico_sns" {
  type    = string
  default = "topico-upload-arquivos"
}

# Nome da fila SQS
variable "nome_fila_sqs" {
  type    = string
  default = "fila-upload-arquivos"
}
