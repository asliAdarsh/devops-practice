// ==============================================
// Task 10: Bind Mounts Demo - Express App
// ==============================================
const express = require("express");
const app = express();
const PORT = 3000;

app.get("/", (req, res) => {
    res.json({
        message: "Hello from Docker!",
        timestamp: new Date().toISOString(),
        note: "Edit this file and refresh to see live changes!"
    });
});

app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
    console.log("Bind mount active: edit app.js to see live changes.");
});
