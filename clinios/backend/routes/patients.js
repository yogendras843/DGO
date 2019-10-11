var express = require('express');
var bcrypt = require('bcrypt');
var jwt = require('jsonwebtoken');
var Patients = require('../models/patients');
var Users = require('../models/users');
var router = express.Router();
var middleware = require('../middleware/index');
var moment = require('moment');
var nodeMailer = require('nodemailer');
var dotenv = require('dotenv');
var saltRounds = 10;

dotenv.config({path: __dirname + '/../.env'});
var mailer = nodeMailer.createTransport({
  host: process.env.MAIL_HOST,
  port: process.env.MAIL_PORT,
  secure: process.env.MAIL_SECURE,
  auth: {
      user: process.env.MAIL_USER,
      pass: process.env.MAIL_PASS
  }
});

//livesearch at the top right of Header.Vue
router.post('/filter', middleware.token, async (req, res, next) => {
  if (req.body.search) {
    var patients = await Patients.getFilter(req.body.search, req.body.client_id);
    res.status(200).json(patients);
  } else {
    res.status(200).json({ patients : []})
  }
});

//initial page load get all patients
/*
router.get('/',  middleware.token,  async (req, res, next) => {
    var patients = await Patients.getAll();
    if (patients) {
      res.status(200).json({
        patients: patients
      });
    } else {
      res.status(200).json({ error : "There are no patients." });
    }
});
*/

//search patients
router.post('/patients-search', async(req, res, next) => {
  var search = req.body
  var patients = await Patients.searchPatients(search);
  if (patients) {
    res.status(200).json({
      patients: patients
    });
  } else {
    res.status(200).json({ error : "There are no patients." });
  }
})

//get patient by id
router.get('/:id', middleware.token, async (req, res, next) => {
    var patient = await Patients.getById(req.params.id);
    var updated = await Users.updateById(req.decoded.data.id, {last_viewed_patient_id: patient.patient.id}); //, client_id: req.decoded.data.client_id});
    if (updated.error) {
      res.status(200).json(updated);
    } else {
      res.status(200).json(patient);
    }
});

//insert user patient log
router.post('/user-log', middleware.token, async (req, res, next) => {
  try {
    let userlog =  await Patients.insertUserLog(req.body);
    res.status(200).json({ userlog : userlog });
  } catch (err) {
    res.status(200).json({ error : "While creating the user log an unexpected error occured." });
  }
});

//edit patient
router.post('/:id', middleware.token, async (req, res, next) => {
    delete req.body.permission;
    req.body.created = req.body.created.split('T')[0];
    req.body.updated = moment().format().split('T')[0];
    var patient = await Patients.updateById(req.params.id, req.body);
    res.status(200).json({ patient: patient });
});


////////////////////
//patient portal
////////////////////

//patient login
router.post('/login', async (req, res, next) => {
  var patient = req.body;
  // check existing patient with the email in patient table
  var exist = await Patients.getByEmail(patient.email)
  if (exist.error) {
    return res.status(200).json(exist);
  } else {
    //  compare password hash
    var match = await bcrypt.compare(patient.password, exist.password)
    if (exist.status == 0) {
      res.status(200).json({ error : "Patient status is not active." });
    } else {
      if (match) {
      //  jwt token creation and set expire time.
        var token = jwt.sign({ data: exist }, 'secret', { expiresIn: 60 * 60 * 24 });
        res.status(200).json({
          user: exist, token: token
        })
      } else {
        res.status(200).json({ error : "The password is incorrect." });
      }
    }
  }
});

//email verify to change forgot password
router.post('/verify', async (req, res, next) => {
  // find user by email column from user table
  var exist = await Patients.getByEmail(req.body.email);
  if (exist.length) {
    // random unique url generation for email verify
    var uniqid = uuid.v1();
    // save this link to this user table
    await Patients.updateById(exist[0].id, { verify_token: uniqid });
    // send mail to this user email address containing verify url using nodemailer library
    mailer.sendMail({
      to: req.body.email,
      subject: "Please visit following link",
      text: "Please confirm your email.",
      html: `<a href='http://${req.headers.host}/patient-reset/${uniqid}'>CLICK ME</a>`
    }, (err, result) => {
      if (err) res.status(200).json({ error: "While sending mail to the email address an unexpected error occured."});
      res.status(200).json({ result: result });
    }) 
  } else {
    res.status(200).json({ error: "The email address does not exist."});
  }
});

//reset password
router.post('/reset', async (req, res, next) => {
  // incoming url compare verify column of user
  var exist = await Patients.getByToken(req.body.verify_token);
  if (exist.error) {
    res.status(200).json(exist);
  } else {
    // password setting
    var params = {
      password: await bcrypt.hash(req.body.password, 10),
      verify_token: null
    }
    // password updating
    var result = await Patients.updateById(exist.id, params);
    res.status(200).json({patient: result});
  }
})

//update patient profile
router.post('/profile', middleware.token, async (req, res, next) => {
  delete req.body.permission;
  req.body.created = req.body.created.split('T')[0]
  req.body.updated = moment().format().split('T')[0];
  if (req.body.password != "") {
    req.body.password = await bcrypt.hash(req.body.password, saltRounds);
  } else {
    delete req.body.password;
  }
  var patient = await Patients.updateById(req.decoded.data.id, req.body);
  res.status(200).json(patient);
});

module.exports = router;
