# Tópico SNS
resource "aws_sns_topic" "topic_upload_arquivos" {
  name = var.nome_topico_sns
}

# Fila SQS
resource "aws_sqs_queue" "fila_upload_arquivos" {
  name = var.nome_fila_sqs
}

# Associa o tópico SNS à fila SQS
resource "aws_sns_topic_subscription" "assinatura_sqs" {
  topic_arn = aws_sns_topic.topic_upload_arquivos.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.fila_upload_arquivos.arn
}

# Permitir que o SNS publique mensagens na fila SQS
resource "aws_sqs_queue_policy" "politica_sns_para_sqs" {
  queue_url = aws_sqs_queue.fila_upload_arquivos.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "SQS:SendMessage"
        Resource = aws_sqs_queue.fila_upload_arquivos.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.topic_upload_arquivos.arn
          }
        }
      }
    ]
  })
}
