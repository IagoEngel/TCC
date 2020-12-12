'use strict'
const mongoose =require('mongoose');
const repository = require("../repositories/tabela-repository");
const solo = require('../models/solo');
const Solo = mongoose.model('Solo');

exports.get = async() =>{
    const res =  await Solo.find({
        active:true
       },'hexa descricao');

       return res;
};

exports.diferenca = async(hexa1) =>{

 const tte = `#${hexa1}`;
 console.log(tte);
  function calcula(tte,hexa2){

    const hexToRgb = hex =>
    hex.replace(/^#?([a-f\d])([a-f\d])([a-f\d])$/i
               ,(m, r, g, b) => '#' + r + r + g + g + b + b)
      .substring(1).match(/.{2}/g)
      .map(x => parseInt(x, 16));
  

    
      const rgb1 = hexToRgb(tte);
      const rgb2 = hexToRgb(hexa2);
        
          const [ r1, g1, b1 ] = rgb1;
          const  [ r2, g2, b2 ] = rgb2;
          const drp2 = Math.pow((r1 - r2), 2);
          const dgp2 = Math.pow((g1 - g2), 2);
          const dbp2 = Math.pow((b1 - b2), 2);
          const t = (r1 + r2) / 2;
           
       
           const resposta = Math.sqrt(2 * drp2 + 4 * dgp2 + 3 * dbp2 + t * (drp2 - dbp2) / 256)
          //console.log(resposta);
           //return String(resposta);
            return resposta;
          }

            var data = await repository.get();
            var retorno =[];
            
            data.forEach((item)=>{
         
              const resposta = calcula(tte,item.hexa);
              
              if(resposta <= 45){
 
                 retorno.push(item);
               
               
              }
              else{
               
              }
             
                                     
             });
             if(retorno.length >0){
               return retorno;
             }else{
               return {"message":"Nada encontrado"};
             }
           
          
          
          


};

exports.create = async(data) =>{

  var solo = new Solo(data);
  await solo.save();

};



exports.update = async(id,data) => {
   
    await Solo
          .findByIdAndUpdate(id, {
           $set: {
            hexa: data.hexa,
            descricao: data.descricao
           
        }
    });
};

exports.delete = async(id) =>{
    await Solo.findOneAndRemove(id);
}








