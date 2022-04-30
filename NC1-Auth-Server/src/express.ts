import express, { urlencoded } from "express";
import router from "./router";
import morgan from "morgan";

const app = express();

app.use(urlencoded());
app.use(express.json());
app.use(morgan("dev"));

app.use("/auth", router);

export default app;
