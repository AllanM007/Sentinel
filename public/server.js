const dotenv = require("dotenv");
dotenv.config();
const express = require("express");
const app = express();
const url = require("url");
const path = require("path");
const axios = require("axios");
const bodyParser = require("body-parser");

const router = express.Router();

app.use(
  bodyParser.urlencoded({
    extended: true,
  })
);

router.get("/", function (req, res) {
  res.sendFile(path.join(__dirname + "/views/index.html"));
});

router.post("/newContact", function (req, res) {
  // console.log(req);
  const FormData = req.body;
  console.log(req.body);

  request
    .then((result) => {
      console.log(result.body);
      res.send({
        status: 200,
        message: "Request Succesful",
      });
    })
    .catch((err) => {
      console.log(err.response.status);
      res.send({
        status: err.response.status,
        message: err.response.statusText,
      });
    });
});

//add the router
app.use("/", router);
app.listen(process.env.port || 3003);
app.use(express.static(path.join(__dirname, "public")));
app.use("/js", express.static(__dirname + "/js"));

console.log("Running at Port 3003");
