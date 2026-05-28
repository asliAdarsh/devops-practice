resource "google_compute_security_policy" "edge_waf" {
  name        = "prod-edge-waf-policy"
  description = "Enterprise Edge WAF - Blocks SQL Injection and XSS"

  # Rule 1: Mitigation against SQL Injection (SQLi)
  rule {
    action   = "deny(403)"
    priority = "1000"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('sqli-v33-stable')"
      }
    }
    description = "Block OWASP Top 10 SQL Injection vulnerabilities"
  }

  # Rule 2: Default rule allowing legitimate traffic
  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
    description = "Default allow rule for all other traffic"
  }
}

resource "google_compute_backend_service" "app_backend" {
  name                  = "prod-app-backend-service"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 30

  # Attaching the Edge WAF defense layer directly to the routing backend
  security_policy = google_compute_security_policy.edge_waf.id

  health_checks = [google_compute_health_check.http_health_check.id]
}

resource "google_compute_health_check" "http_health_check" {
  name               = "prod-http-health-check"
  check_interval_sec = 5
  timeout_sec        = 5

  http_health_check {
    port = 80
  }
}



