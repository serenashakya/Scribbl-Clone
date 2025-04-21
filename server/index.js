const express = require("express");
var http = require("http");
const mongoose = require("mongoose");
const { Server } = require("socket.io");

const app = express();
const port = process.env.PORT || 3000;
var server = http.createServer(app);
var io = require('socket.io')(server);
const Room = require('./models/Room');
const getWord = require('./api/getWord');

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

  io.on('connection', (socket) => {
    console.log('connected');
    socket.on('create-game', async({nickname, name, occupancy, maxRounds})=>{
        try{
            const existingRoom = await Room.findOne({name});
            if(existingRoom){
                socket.emit('notCorrectGame', 'Room iwith taht name already exists!');
                return;
            }
            let room = new Room();
            const word = getWord();
            room.word = word;
            room.name = name;
            room.occupancy = occupancy;
            room.maxRounds = maxRounds;

            let player = {
                socketID: socket.id,
                nickname,
                isPartyLeader: true,
            }
            room.players.push(player);
            room = await room.save();
            socket.join(room);
            io.to(name).emit('upadateroom'.room);
        }catch(err){
            console.log(err);
        }
    })
  })

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
