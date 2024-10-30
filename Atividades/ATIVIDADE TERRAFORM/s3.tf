# Itera 'for_each' para criar cada bucket da lista nomes_buckets_s3 em variables
resource "aws_s3_bucket" "buckets" {
  for_each = toset(var.nomes_buckets_s3)
  bucket   = each.value
}

output "buckets_s3" {
  value = [for bucket in aws_s3_bucket.buckets : bucket.bucket]
}

resource "aws_s3_bucket_notification" "notificacoes_buckets" {
  for_each = { for k, v in aws_s3_bucket.buckets : k => v if k != "local-files" }

  bucket = each.value.id

  topic {
    topic_arn = aws_sns_topic.topic_upload_arquivos.arn
    events    = ["s3:ObjectCreated:*"]
  }
}