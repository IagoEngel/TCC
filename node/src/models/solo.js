'use strict'

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const schema = new Schema({
    hexa: {
        type: String,
        required: true,
        trim: true
    },
    descricao: {
        type: String,
    }

});


module.exports = mongoose.model('Solo', schema);