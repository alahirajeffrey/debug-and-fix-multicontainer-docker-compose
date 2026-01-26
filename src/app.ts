import express, { Application } from "express";

const app: Application = express();

app.use(express.json());

app.get("/", (_, res) => {
  res.json({ status: "OK" });
});

app.get("/health", (_, res) => {
  res.status(200).json({ status: "healthy" });
});

export default app;
