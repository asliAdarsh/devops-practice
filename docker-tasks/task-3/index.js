import express from "express";
import { createClient } from "redis";

const app = express();
const port = 3000;

// Redis connection (use service name "db" as host)
const redisClient = createClient({
  socket: {
    host: process.env.REDIS_HOST || "localhost",
    port: process.env.REDIS_PORT || 6379,
  },
});

redisClient.on("error", (err) => {
  console.error("Redis error:", err);
});

await redisClient.connect();

app.get("/", async (req, res) => {
  const visits = await redisClient.incr("page_visits");
  res.send(`Page visited ${visits} times`);
});

app.listen(port, () => {
  console.log(`Web app listening on port ${port}`);
});
