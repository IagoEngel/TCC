"use strict";

const repository = require("../repositories/tabela-repository");
const { restart } = require("nodemon");

exports.get = async (req, res, next) => {
  try {
    var data = await repository.get();
    res.status(200).send(data);
  } catch (e) {
    res.status(200).send({
      message: "Falha ao processar requisição",
    });
  }
};






exports.post = async (req, res, next) => {

  

  try {
    await repository.create({
      nutriente: req.body.nutriente,
      notacao: req.body.notacao,
      hexa: req.body.hexa,
      nomecor: req.body.nomecor
    });
    res.status(201).send({
      message: "Tabela cadastrado com sucesso",
    });
  } catch (e) {
    res.status(200).send({
      message: "Falha ao processar requisição" + e.message,
    });
  }
};






exports.put = async(req,res,next) =>{

    try{
      await repository.update(req.params.id, req.body);
      res.status(200).send({
          message:'Tabela atualizado com sucesso'
      });
    }catch(e){
        console.log(e);
      res.status(500).send({
          message:'Erro ao atulaizar o Beneficio'
      });
    }
};


exports.delete = async(req,res,nex) =>{
    try{
        await repository.delete(req.body.id);
        res.status(200).send({
            message:"Tabela deletado com sucesso"
        });
    }catch(e){
        res.status(500).send({
            message:"Falha ao deletar o Tabela"
        });
    }
    
};