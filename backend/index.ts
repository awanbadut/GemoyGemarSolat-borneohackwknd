import type { Request, Response } from "express";
import express from "express";
import cors from "cors";
import "dotenv/config"; // Cara import dotenv di TS
import authRoutes from "./src/routes/authRoutes";

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.use("/api/auth", authRoutes);

app.get("/", (req: Request, res: Response) => {
  res.send("API Hackathon ASEAN Pet Language is Running with TypeScript!");
});

app.listen(PORT, () => {
  console.log(`Server ngebut di port ${PORT} brok!`);
});
