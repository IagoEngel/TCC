'use strict'
const mongoose =require('mongoose');
const tabela = require('../models/tabela');
const Tabela = mongoose.model('Tabela');

exports.get = async() =>{
    const res =  await Tabela.find({
       },'nutriente notacao hexa nomecor');

       return res;
};




exports.create = async(data) =>{

  var tabela = new Tabela(data);
  await tabela.save();

};



exports.update = async(id,data) => {
   
    await Tabela
          .findByIdAndUpdate(id, {
           $set: {
            nutriente: data.nutriente,
            notacao: data.notacao,
            hexa: data.hexa,
            nomecor: data.nomecor
        }
    });
};

exports.delete = async(id) =>{
    await Tabela.findOneAndRemove(id);
}








