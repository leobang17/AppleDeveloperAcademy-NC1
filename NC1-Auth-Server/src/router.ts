import express from "express";
import { DIContainer } from "./DIContainer";
import { UserInputDto } from "./models/dto";

const router = express.Router();
const diContainer = new DIContainer();
const authService = diContainer.getService();

router.get("/", (req, res) => {
  res.send("index return");
});

router.post("/signup", (req, res) => {
  const body = req.body as UserInputDto;
  const result = authService.createUser(body);
  res.json(result);
});

router.get("/all", (req, res) => {
  const result = authService.getAllUsers();
  res.json(result);
});

export default router;
