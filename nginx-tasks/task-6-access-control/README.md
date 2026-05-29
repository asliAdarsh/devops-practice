# Task 6: Access Control (The Spy)

## Task Overview
Learn how to control **who can access** your Nginx server using IP-based allow/deny rules and HTTP Basic Authentication. This is essential for restricting access to admin panels, staging environments, or sensitive endpoints.

## Key Concepts
- **`allow`/`deny` directives**: Control access by client IP address
- **`satisfy any`**: Allow access if ANY access control rule passes (IP allow OR auth)
- **`satisfy all`**: Require ALL access control rules to pass
- **`auth_basic`**: Enable HTTP Basic Authentication with a username/password prompt
- **`auth_basic_user_file`**: Points to the `.htpasswd` file containing credentials
- **`.htpasswd` file**: Stores encrypted username:password pairs (use `openssl passwd` to generate)
- **Order matters**: `allow`/`deny` rules are evaluated in order; the last matching rule wins

## Files in This Task

| File | Purpose |
|------|---------|
| `README.md` | This file — explains the task |
| `nginx.conf` | Access control configuration with allow/deny and auth_basic |
| `dockerfile` | Docker image for Nginx with access control |
| `docker-compose.yaml` | Spins up Nginx + backend |
| `.htpasswd` | Encrypted credentials for Basic Auth |
| `backend/server.js` | Simple Express server |
| `backend/package.json` | Node.js dependencies |
| `backend/dockerfile` | Docker image for backend |

## Step-by-Step Instructions

### 1. Create the `.htpasswd` File (if it doesn't exist)
```bash
cd task-6-access-control

# Generate a password for user "admin"
# (already provided in this task, but here's how to create your own)
htpasswd -c .htpasswd admin
# Enter password: admin123
```

### 2. Start the Services
```bash
docker compose up --build
```

### 3. Test IP-Based Access Control
```bash
# Access from allowed IP (localhost/127.0.0.1) — should succeed
curl http://localhost:80

# The nginx.conf allows 127.0.0.1 and denies all others
```

### 4. Test Basic Authentication
The `/admin` location requires a username and password:
```bash
# Without credentials — gets 401 Unauthorized
curl http://localhost:80/admin

# With credentials — gets 200 OK
curl -u admin:admin123 http://localhost:80/admin
```

### 5. Test `satisfy any` Behavior
```bash
# If you're on an allowed IP, you bypass auth
# If you're on a blocked IP, you MUST authenticate
```

## Verification Steps

```bash
# Test root path (IP-based access)
curl -I http://localhost:80

# Test admin path without auth
curl -I http://localhost:80/admin

# Test admin path with correct auth
curl -u admin:admin123 -I http://localhost:80/admin

# Test admin path with wrong password
curl -u admin:wrongpass -I http://localhost:80/admin

# Test blocked IP (simulate by adding a header)
# You'll get 403 Forbidden
```

## Common Mistakes

| Mistake | What Happens | How to Fix |
|---------|-------------|------------|
| `allow`/`deny` in wrong order | Unexpected blocks (last matching rule wins) | Put `allow` before `deny` |
| Missing `satisfy any` | Both IP AND auth required, blocking legit users | Use `satisfy any` when either method should grant access |
| `.htpasswd` not copied to image | Auth always fails (500 error) | Add `COPY .htpasswd /etc/nginx/` to dockerfile |
| Using plain text passwords in `.htpasswd` | Auth fails | Use `openssl passwd -apr1` to encrypt passwords |
| No `auth_basic_user_file` path | Auth prompt shows but never accepts | Verify `.htpasswd` exists at the specified path |

## Best Practices
1. **Layer access controls**: Use IP allow + Basic Auth together for defense in depth
2. **Use `satisfy any` for admin panels**: Allow office IPs to bypass auth, but require auth from elsewhere
3. **Store `.htpasswd` securely**: Never commit passwords to public repos (add to `.gitignore`)
4. **Use HTTPS in production**: Basic Auth sends passwords in base64 (easily decoded without HTTPS)
5. **Create separate `.htpasswd` files** for different user roles (admin, readonly, etc.)

## Success Criteria
- [ ] IP-based access control works (allowed IPs get 200, denied get 403)
- [ ] Basic Authentication prompts for credentials on protected routes
- [ ] Correct credentials return 200 OK
- [ ] Wrong credentials return 401 Unauthorized
- [ ] `satisfy any` allows either IP or auth to grant access
- [ ] `.htpasswd` file is properly formatted with encrypted passwords
