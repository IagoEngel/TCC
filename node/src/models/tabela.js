'use strict'

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const schema = new Schema({
    nutriente: {
        type: String,
        required: true,
        trim: true
    },
    notacao: {
        type:String,
    },
    hexa: {
        type: String,
        required: true,
        trim: true
    },
    nomecor:{
        type: String,
    
    },
});


module.exports = mongoose.model('Tabela', schema);