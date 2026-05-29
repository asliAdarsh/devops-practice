# Task 11: Database Keeper - Persistent Volumes

## Task Overview
Learn how to use **Docker named volumes** with a database (PostgreSQL) to persist data across container restarts, which is essential for stateful applications.

## Key Concepts
- **Database Persistence**: Databases must store data outside the container filesystem
- **Named Volume vs Bind Mount**: Volumes are managed by Docker, not dependent on host directory structure
- **Volume Drivers**: Support for NFS, cloud storage, and other backends
- **Backup & Restore**: Volumes can be backed up using temporary helper containers

## Files in This Task

| File | Purpose |
|------|---------|
| `docker-compose.yaml` | PostgreSQL service with a named volume |
| `init.sql` | Initial SQL script to seed the database |

## Step-by-Step Instructions

### 1. Start PostgreSQL
```bash
cd docker-tasks/task-11-persistent-volumes
docker compose up -d
```

### 2. Connect and create data
```bash
docker exec -it task-11-persistent-volumes-db-1 psql -U postgres -c "CREATE DATABASE testdb;"
docker exec -it task-11-persistent-volumes-db-1 psql -U postgres -d testdb -c "CREATE TABLE items (id SERIAL, name TEXT);"
docker exec -it task-11-persistent-volumes-db-1 psql -U postgres -d testdb -c "INSERT INTO items (name) VALUES ('persistent-data');"
```

### 3. Restart and verify
```bash
docker compose down
docker compose up -d
docker exec -it task-11-persistent-volumes-db-1 psql -U postgres -d testdb -c "SELECT * FROM items;"
```

## Verification Steps
- [ ] Data survives `docker compose down` + `docker compose up`
- [ ] `docker volume ls` shows the PostgreSQL volume
- [ ] Data is only removed with `docker compose down -v`

## Success Criteria
- [ ] PostgreSQL container starts and initializes
- [ ] Data is written to the database and persists across restarts
- [ ] Volume is visible with `docker volume ls`
- [ ] Database can be reset by removing the volume
