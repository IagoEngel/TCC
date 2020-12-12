'use strict'
const express = require('express');
const router = express.Router();
const controller = require('../controllers/solo-controller');

router.get('/', controller.get);
 router.post('/',controller.post);
 router.put('/:id',controller.put);
 router.delete('/',controller.delete);
 router.get('/diferenca', controller.diferenca);


module.exports = router;