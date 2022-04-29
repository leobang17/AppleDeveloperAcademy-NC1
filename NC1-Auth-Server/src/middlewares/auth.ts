import { NextFunction, Request, Response } from "express";
import { BaseResponse } from "../baseReponse";
import { DIContainer } from "../DIContainer";
import jwt, { JsonWebTokenError, JwtPayload } from "jsonwebtoken";

const diContainer = DIContainer.instance;
const userService = diContainer.getService();

export const authenticate = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const authHeader = req.headers["authorization"];
  if (!authHeader) {
    res.json(new BaseResponse("헤더 없음", "false"));
    return;
  }
  const token = authHeader.split(" ")[1];

  let decoded;
  try {
    decoded = jwt.verify(token, "SECRET");
  } catch (err) {
    res.json(new BaseResponse("verify 실패", "false"));
    return;
  }

  const persistedUser = userService.findUserByUsername(
    (decoded as { username: string }).username
  );

  if (!persistedUser) {
    res.json(new BaseResponse("유저 없음", "false"));
  }
  next();
};
