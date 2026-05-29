# Task 7: Security Headers (The Hardened Shell)

## Task Overview
Learn how to **harden your Nginx server** by adding security-related HTTP response headers. These headers instruct browsers to enable security features that protect your users from common web attacks.

## Key Concepts
- **`X-Frame-Options`**: Prevents clickjacking by controlling whether your site can be embedded in an iframe
- **`X-Content-Type-Options`**: Prevents MIME-type sniffing (browsers won't guess content types)
- **`Strict-Transport-Security` (HSTS)**: Forces browsers to always use HTTPS
- **`Content-Security-Policy` (CSP)**: Controls which resources (scripts, styles, images) can be loaded
- **`X-XSS-Protection`**: Enables browser's built-in XSS filter (deprecated but still used)
- **`Referrer-Policy`**: Controls what referrer info is sent with requests
- **`Permissions-Policy`**: Controls which browser APIs (camera, microphone, etc.) your site can use
- **`Cache-Control`**: Controls how browsers and proxies cache your content

## Files in This Task

| File | Purpose |
|------|---------|
| `README.md` | This file — explains the task |
| `nginx.conf` | Nginx config with security headers |
| `dockerfile` | Docker image for Nginx with security headers |
| `docker-compose.yaml` | Spins up Nginx + backend |
| `backend/server.js` | Simple Express server |
| `backend/package.json` | Node.js dependencies |
| `backend/dockerfile` | Docker image for backend |

## Step-by-Step Instructions

### 1. Start the Services
```bash
cd task-7-security-headers
docker compose up --build
```

### 2. Inspect Security Headers
```bash
# View all response headers
curl -I http://localhost:80

# You should see headers like:
# X-Frame-Options: DENY
# X-Content-Type-Options: nosniff
# Strict-Transport-Security: max-age=31536000
# Content-Security-Policy: default-src 'self'
# Referrer-Policy: no-referrer
# Permissions-Policy: geolocation=(), camera=(), microphone=()
```

### 3. Check Security Headers with a Tool
```bash
# Use a browser or security header checker online
# Visit: https://securityheaders.com/ and enter your URL

# Or use curl to get a summary
curl -sI http://localhost:80 | grep -i "^\(x-\|strict-\|content-security\|referrer\|permissions\)"
```

### 4. Test CSP in Action
The CSP header blocks inline scripts and external resources:
```bash
# Open http://localhost:80 in a browser
# Open DevTools → Console to see CSP violation warnings
```

### 5. Modify Headers
Edit `nginx.conf` to customize the security headers, then restart:
```bash
docker compose restart nginx
```

## Verification Steps

```bash
# Check all security headers are present
curl -I http://localhost:80 2>&1

# Grade your site's security
# A+ = all major headers present and properly configured
# F = missing critical headers

# Verify CSP blocks inline scripts
# Check browser console for CSP errors

# Verify HSTS header
curl -sI http://localhost:80 | grep -i "strict-transport"

# Test clickjacking protection (X-Frame-Options)
curl -sI http://localhost:80 | grep -i "x-frame-options"
```

## Common Mistakes

| Mistake | What Happens | How to Fix |
|---------|-------------|------------|
| CSP too strict (`default-src 'none'`) | Site looks broken (no CSS, no images) | Use `default-src 'self'` and add specific directives |
| HSTS with short `max-age` | Weak protection | Use `max-age=31536000` (1 year) minimum |
| Missing `includesSubDomains` on HSTS | Subdomains aren't protected | Add `includeSubDomains` to HSTS |
| Setting `X-Frame-Options` to `ALLOWALL` | No clickjacking protection | Use `DENY` or `SAMEORIGIN` |
| Overly permissive CSP (`unsafe-inline`) | Defeats CSP purpose | Avoid `unsafe-inline` and `unsafe-eval` |
| Wrong header syntax | Headers not applied | Check for missing semicolons or quotes in CSP |

## Best Practices
1. **Start strict and relax as needed** — begin with a restrictive CSP, then add exceptions for resources you need
2. **Use `add_header` with `always`** to ensure headers are sent even on error responses (4xx/5xx)
3. **Test CSP with `report-uri` or `report-to`** to monitor violations before enforcing
4. **Set HSTS only after HTTPS is working** — otherwise you'll lock users out of HTTP
5. **Audit your headers regularly** using tools like securityheaders.com or Mozilla Observatory

## Success Criteria
- [ ] `X-Frame-Options: DENY` prevents clickjacking
- [ ] `X-Content-Type-Options: nosniff` prevents MIME sniffing
- [ ] `Strict-Transport-Security` forces HTTPS connections
- [ ] `Content-Security-Policy` controls resource loading
- [ ] `Referrer-Policy` limits referrer information leakage
- [ ] `Permissions-Policy` restricts browser API access
- [ ] All headers are returned on both success (200) and error (404) responses
