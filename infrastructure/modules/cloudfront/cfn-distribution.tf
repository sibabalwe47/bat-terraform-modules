/*
 *  Random ID generator
 */
resource "random_id" "backend_id" {
  byte_length = 5
}


/*
 *  CloudFront Distribution
 */
resource "aws_cloudfront_distribution" "elb_distribution" {

  origin {
    domain_name = var.domain_name
    origin_id   = var.alb_origin_id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.1"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "/"
  aliases             = var.domain_aliases
  http_version        = "http1.1"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.alb_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }



  viewer_certificate {
    acm_certificate_arn            = var.acm_certification_arn
    cloudfront_default_certificate = false
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  tags = {
    Name = "${var.project_name}-cfn-distribution-${random_id.backend_id.dec}"
  }
}
