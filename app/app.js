const express = require("express");

const app = express();
app.use(express.json());

app.get("/", (req, res) => {
  res.json({ status: "OK" });
});

app.get("/health", (req, res) => {
  res.status(200).json({ status: "healthy" });
});

module.exports = app;
