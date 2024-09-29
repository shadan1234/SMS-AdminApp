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
    
    timestamp:{
        default:Date.now,
        type:Date

    },
   
});

const Message= mongoose.model('Message',messageSchema);
module.exports=Message;