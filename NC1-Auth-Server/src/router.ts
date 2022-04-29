import express from "express";
import { DIContainer } from "./DIContainer";
import { SignInDto, UserInputDto } from "./models/dto";
import { authenticate } from "./middlewares/auth";

const router = express.Router();
const diContainer = DIContainer.instance;
const authService = diContainer.getService();

router.get("/", (req, res) => {
  res.send("index return");
});

router.post("/signup", (req, res) => {
  const body = req.body as UserInputDto;
  const result = authService.createUser(body);
  res.json(result);
});

router.get("/all", authenticate, (req, res) => {
  const result = authService.getAllUsers();
  res.json(result);
});

router.post("/signin", (req, res) => {
  const body = req.body as SignInDto;
  res.json(authService.signIn(body));
});

export default router;
