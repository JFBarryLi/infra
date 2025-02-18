resource "aws_route53_record" "mx_google_email" {
  count = var.email_forwarding ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id
  name    = var.domain
  type    = "MX"
  ttl     = 3600

  records = [
    "10 mxa.mailgun.org",
    "10 mxb.mailgun.org",
  ]
}

resource "aws_route53_record" "squarespace_spf" {
  count = var.email_forwarding ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id
  name    = var.domain
  type    = "TXT"
  ttl     = "3600"

  records = ["v=spf1 include:mailgun.org include:_spf.google.com ~all"]
}

resource "aws_route53_record" "squarespace_dkim" {
  count = var.email_forwarding ? 1 : 0

  zone_id = aws_route53_zone.this.zone_id
  name    = "mailo._domainkey.${var.domain}"
  type    = "TXT"
  ttl     = "3600"

  records = [
    "k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC6CY3v6K3NI9z5SqlCswxwJwDgWsgCcpA89V9EfA820wXP4N5+7cFy9pX0YUHCg/gKcMaR/VBci5PddddZ2PE8pzQNbiNgEmB7sZclJ+KsviGVJxNaBccehHGyCNVM8CR+BEkmcTacJSkAjo2TlTRoENdggoPql/Mn189tOV0OYQIDAQAB"
  ]
}
