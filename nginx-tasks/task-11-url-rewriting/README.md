# Task 11: URL Rewriting (The Masquerade)

## Task Overview
Learn how to **rewrite and redirect URLs** using Nginx's powerful `rewrite` directive. URL rewriting allows you to change request URLs on the fly — useful for SEO-friendly URLs, migrating from old URLs to new ones, and creating clean URL structures.

## Key Concepts
- **`rewrite` directive**: Changes the URL using a regex pattern and replacement string
- **`last` flag**: Stop processing rewrites and restart the location search with the new URL
- **`break` flag**: Stop processing rewrites but DON'T restart location search
- **`redirect` flag**: Return a temporary redirect (302) to the client
- **`permanent` flag**: Return a permanent redirect (301) to the client
- **`return` directive**: Simpler than `rewrite` for basic redirects (301, 302, etc.)
- **`try_files` directive**: Checks for files in order; useful with SPA fallback
- **Named captures**: Use regex groups like `$1`, `$2` to capture parts of the URL
- **Internal vs external redirects**: Internal redirects happen server-side (no round trip to client)

## Files in This Task

| File | Purpose |
|------|---------|
| `README.md` | This file — explains the task |
| `nginx.conf` | Nginx config with various rewrite examples |
| `dockerfile` | Docker image for Nginx with URL rewriting |
| `docker-compose.yaml` | Spins up Nginx + backend |

## Step-by-Step Instructions

### 1. Start the Services
```bash
cd task-11-url-rewriting
docker compose up --build
```

### 2. Test URL Rewrites
```bash
# 301 Redirect: old-page → new-page
curl -I http://localhost/old-page
# Response: 301 Moved Permanently, Location: /new-page

# 302 Temporary Redirect: /temp → /new-page
curl -I http://localhost/temp
# Response: 302 Found, Location: /new-page
```

### 3. Test Regex-Based Rewrites
```bash
# Rewrite /products/123 → /product?id=123
curl http://localhost/products/42
# Response should show the rewritten URL was used

# Rewrite /user/adarsh → /profile?username=adarsh
curl http://localhost/user/adarsh
```

### 4. Test SEO-Friendly URLs
```bash
# Clean URL: /articles/hello-world → /article.php?slug=hello-world
curl http://localhost/articles/hello-world
```

### 5. Test `try_files` (SPA Fallback)
```bash
# Static file exists — served directly
curl http://localhost/app/index.html

# Route doesn't exist — falls back to /app/index.html
curl http://localhost/app/some/deep/route
```

### 6. Test Breaking Rewrite Loops
```bash
# The nginx.conf is designed to prevent infinite redirect loops
# Try rewriting in a creative way and watch Nginx detect the loop
```

## Verification Steps

```bash
# Check redirect status codes
curl -I http://localhost/old-page | grep "HTTP\|Location"
curl -I http://localhost/temp | grep "HTTP\|Location"

# Check rewritten URLs serve the right content
curl http://localhost/products/42

# Verify regex captures work
curl http://localhost/user/john-doe

# Test try_files fallback
curl http://localhost/app/anything

# Verify no infinite loops
curl http://localhost/loop
```

## Common Mistakes

| Mistake | What Happens | How to Fix |
|---------|-------------|------------|
| Forgetting `permanent` or `redirect` flag | Internal redirect (client doesn't know) | Add `break` or `last` flag as appropriate |
| Infinite redirect loop | Browser shows "too many redirects" error | Add a regex condition to prevent re-rewriting |
| Wrong regex escaping | Rewrite never matches | Test your regex with a tool like regex101.com |
| Missing `break` after rewrite | Nginx keeps processing other locations | Use `break` to stop further location matching |
| `rewrite` instead of `return` for simple redirects | Works but less efficient | Use `return 301` for simple, static redirects |
| Not anchoring regex (`^` and `$`) | Unintended matches on similar paths | Always use `^...$` anchors unless you want partial matches |

## Best Practices
1. **Use `return` for simple redirects** — it's faster and clearer than `rewrite`
2. **Always anchor your regex patterns** with `^` and `$` to avoid unexpected matches
3. **Test rewrites with `curl -I`** first to see what redirect headers are returned before following them
4. **Avoid complex regex in rewrites** — they're hard to debug. Break complex rewrites into multiple simple ones
5. **Use `try_files` for SPA routing** instead of rewrites — it's cleaner and more predictable
6. **Add a rewrite log** (`rewrite_log on;`) to debug rewrite behavior

## Success Criteria
- [ ] Permanent redirect (301) works: `/old-page` → `/new-page`
- [ ] Temporary redirect (302) works: `/temp` → `/new-page`
- [ ] Regex-based rewrite captures URL parameters correctly
- [ ] Internal rewrites don't expose the rewritten URL to the client
- [ ] `try_files` falls back to index.html for SPA routes
- [ ] No infinite redirect loops occur
- [ ] SEO-friendly URLs are properly rewritten to internal paths
