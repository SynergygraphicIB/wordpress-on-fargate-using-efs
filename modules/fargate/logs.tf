# Set up CloudWatch group and log stream and retain logs for 30 days

resource "aws_cloudwatch_log_group" "this" {
  name              = var.awslogs-group-path
  retention_in_days = 30

  tags = {
    Name = "${local.app_name}-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "this" {
  name           = "my-log-stream"
  log_group_name = aws_cloudwatch_log_group.this.name
}
