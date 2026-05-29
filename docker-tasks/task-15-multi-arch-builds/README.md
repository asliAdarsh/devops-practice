# Task 15: Universal Builder - Multi-Arch Builds

## Task Overview
Learn how to build Docker images for **multiple CPU architectures** (amd64, arm64, armv7) using Docker Buildx, enabling deployment across different hardware platforms.

## Key Concepts
- **Buildx**: Docker CLI plugin for advanced build features
- **Multi-Architecture**: Single image can support amd64, arm64, and arm/v7
- **QEMU Emulation**: Buildx uses QEMU to emulate different architectures
- **Platform-Specific Builds**: Use `--platform` flag to target specific architectures

## Files in This Task

| File | Purpose |
|------|---------|
| `dockerfile` | Simple multi-arch compatible Dockerfile |
| `README.md` | Instructions and concepts |

## Step-by-Step Instructions

### 1. Enable Buildx
```bash
docker buildx create --use
docker buildx ls
```

### 2. Build for multiple platforms
```bash
cd docker-tasks/task-15-multi-arch-builds
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 \
  -t myapp:multiarch --push .
```

## Success Criteria
- [ ] Buildx builder is created and active
- [ ] Image builds for at least 2 architectures
- [ ] Image manifest lists multiple platforms
- [ ] Understanding how QEMU enables cross-platform builds
