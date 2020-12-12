"use strict";

const repository = require("../repositories/solo.repository");
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
      hexa: req.body.hexa,
      descricao: req.body.descricao,
    });
    res.status(201).send({
      message: "Solo cadastrado com sucesso",
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
          message:'Solo atualizado com sucesso'
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

exports.diferenca = async(req,res,nex) =>{
  try {
    var data = await repository.diferenca(req.query.hexa1);
    res.status(200).send(data);
  } catch (e) {
    res.status(200).send({
      message: "Falha ao processar requisição",
    });
  }
};