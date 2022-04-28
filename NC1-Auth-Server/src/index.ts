import app from "./express";

const PORT = 8080;

app.listen(PORT, () => {
  console.log(`Express server listening on PORT:${PORT}`);
});
