import express from "express";

const router = express.Router();

router.get("/", (req, res) => {
  res.send("index return");
});

router.post("/signin", (req, res) => {
  res.send(req.body);
});

export default router;
