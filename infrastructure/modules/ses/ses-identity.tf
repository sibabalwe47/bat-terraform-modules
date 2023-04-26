/*
 *  SES email identity
 */
resource "aws_ses_email_identity" "ses_identity" {
  email = var.ses_identity_email
}
