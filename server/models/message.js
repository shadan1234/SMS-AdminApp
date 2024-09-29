const mongoose=require('mongoose');

const messageSchema= mongoose.Schema({
    name:{
        type:String,
        required:true
    },
    message:{
        type:String,
        required:true,
    },
    
    createdAt:{
        default:Date.now,
        type:Date

    },
   
});

const Message= mongoose.model('Message',messageSchema);
module.exports=Message;