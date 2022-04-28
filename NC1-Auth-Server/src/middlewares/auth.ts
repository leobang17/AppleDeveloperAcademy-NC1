import { NextFunction, Request, Response } from "express";

export const authenticate = (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const authToken = req.headers["authorization"];

  next();
};
