'use strict'
const express= require('express');
var cors = require('cors')
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const config = require('./config');

const app = express();

const router = express.Router();

//Connect Mongodb
mongoose.connect(config.connectionString,  {
    useUnifiedTopology: true,
    useNewUrlParser: true,
    useCreateIndex: true,
    });

//Carrega Models
const Tabela = require('./models/tabela');
const Solo = require('./models/solo');


//Carrega as Rotas
const indexRoute = require('./routes/index-route');
const tabelaRoute = require('./routes/tabela-routes');
const soloRoute = require('./routes/solo-router');


app.use(bodyParser.json({
    limit: '5mb'
}));
app.use(bodyParser.urlencoded({
    extended: false
}));
app.use(cors());
var cors = require('cors');

app.use(function (req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept, x-access-token');
    res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    next();
});



//mongodb+srv://marcelodlg:21872187m@cluster0.wyr5y.gcp.mongodb.net/sgs?retryWrites=true&w=majority


app.use('/', cors(), indexRoute);
app.use('/tabela',tabelaRoute);
app.use('/solo',soloRoute);
module.exports = app;
