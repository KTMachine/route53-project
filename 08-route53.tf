# Route53 Record
data "aws_route53_zone" "selected" {
  name = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name = "app.${var.domain_name}"
  type = "CNAME"
  ttl = 300
  records = [aws_lb.app.dns_name]
}