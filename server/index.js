const express = require("express");
const http = require("http");
const mongoose = require("mongoose");
const { Server } = require("socket.io");

const app = express();
const port = process.env.PORT || 3000;
const server = http.createServer(app);
const io = new Server(server); // ✅ Correct way

// Middleware
app.use(express.json());

// MongoDB URI
const DB = 'mongodb+srv://shakyaserena:ser123@cluster0.6xgbydk.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';

// Connect to DB
mongoose.connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log("Connection Error:", e);
  });

// Socket.io connection
io.on("connection", (socket) => {
  console.log("A user connected");

  socket.on("disconnect", () => {
    console.log("User disconnected");
  });
});

// Start server
server.listen(port, "0.0.0.0", () => {
  console.log("Server started and running on port " + port);
});
