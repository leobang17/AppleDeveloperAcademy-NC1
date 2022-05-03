import express from "express";
import { DIContainer } from "./DIContainer";
import { SignInDto, UserInputDto } from "./models/dto";
import { authenticate } from "./middlewares/auth";

const router = express.Router();
const diContainer = DIContainer.instance;
const authService = diContainer.getService();

const KAKAO_HOST = "kauth.kakao.com";
const KAKAO_TOKEN = "16445d070b63f98397bacb099d4bab5a";

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

router.get("/kakao", (req, res) => {
  console.log("요청 옴");
  const redirectUrl = `http://localhost:8080/auth/kakao/callback`;
  const url = `https://${KAKAO_HOST}/oauth/authorize?client_id=${KAKAO_TOKEN}&redirect_uri=${redirectUrl}&response_type=code`;
  res.redirect(url);
});

export default router;
