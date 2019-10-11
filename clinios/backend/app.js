var express = require('express');
var path = require('path');
var cors = require('cors');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var logger = require('morgan');

var usersRouter = require('./routes/users');
var patientsRouter = require('./routes/patients')

var app = express();

app.use(cors());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/api/users', usersRouter);
app.use('/api/patients', patientsRouter);
app.use('/*', (req, res) => {
    res.sendFile(path.join(__dirname, '/public/index.html'), function(err) {
        if (err) {
            res.status(500).send(err)
        }
    })
})

module.exports = app;
