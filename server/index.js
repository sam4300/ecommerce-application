//imports for dependencies
const express = require('express');
const mongoose = require('mongoose');
const DB = "mongodb+srv://samar:Godamchour@cluster0.id7cro2.mongodb.net/";

//imports from other files
const authRouter = require('./routes/auth');

//inti
const PORT = 3000;
const app = express();

//middleware
app.use(express.json());
app.use(authRouter);

//connection to database
mongoose.connect(DB).then(()=>{
    console.log("Connected to MongoDB");
});



app.listen(PORT,"0.0.0.0",() => {
    console.log(`Server is running on port ${PORT}`);

});





