var express = require('express');
var bcrypt = require('bcrypt');
var jwt = require('jsonwebtoken');
var uuid = require('uuid');
var saltRounds = 10;
var Users = require('../models/users');
var Patients = require('../models/patients');
var Schedules = require('../models/schedules');
var router = express.Router();
var middleware = require('../middleware/index');
var nodeMailer = require('nodemailer');
var moment = require('moment');
var dotenv = require('dotenv');

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

//user login
router.post('/login', async (req, res, next) => {
  var user =  {email, password} = req.body;
  //var ip = req.ip;
  var ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress || req.socket.remoteAddress || (req.connection.socket ? req.connection.socket.remoteAddress : null);
  var users = await Users.getByEmail(user.email, ip);
  if (users.error) {
    res.status(200).json(users);
  } else {
    // compare password hash
    var match = await bcrypt.compare(user.password, users[0].password)
    if (match) {
      if (users[0].status == 0) {
        res.status(200).json({ error : "User status is not active." });
      } else {
        // jwt token creation and set expire time.
        var token = jwt.sign({ data: users[0] }, 'secret', { expiresIn: 60 * 60 * 24 });
        var last_viewed_patient = null;
        if (users[0].last_viewed_patient_id) {
            last_viewed_patient = await Patients.getById(users[0].last_viewed_patient_id);
        }
        res.status(200).json({
          user: users[0], token: token, last_viewed_patient: last_viewed_patient.patient ? last_viewed_patient.patient : null
        })
      }
    } else {
      res.status(200).json({ error : "The password is incorrect." });
    }
  }
});

//email verify for changing password
router.post('/verify', async (req, res, next) => {
  // find user by email column from user table
  var users = await Users.getByEmail(req.body.email);
  if (users.error) {
    res.status(200).json(users);
  } else {
    // random unique url generation for email verify
    var uniqid = uuid.v1();
    // save this link to this user table
    await Users.updateById(users[0].id, { verify_token: uniqid });
    // send mail to this user email address containing verify url using nodemailer library
    mailer.sendMail({
      to: req.body.email,
      subject: "Please visit following link",
      text: "Please confirm your email.",
      html: `<a href='http://${req.headers.host}/reset/${uniqid}'>CLICK ME</a>`
    }, (err, result) => {
      if (err) res.status(200).json({ error: "While sending mail to your email address, an unexpected error occurs."});
      res.status(200).json({ result: result });
    }) 
  }
});

//password reset
router.post('/reset', async (req, res, next) => {
  // incoming url compare verify column of user
  var users = await Users.getByToken(req.body.verify_token);
  if (users.error) {
    res.status(200).json(users)
  } else {
    // password setting
    var params = {
      password: await bcrypt.hash(req.body.password, saltRounds),
      verify_token: null
    }
    // password updating
    try {
      var result = await Users.updateById(users[0].id, params);
      res.status(200).json({result});
    } catch (err) {
      res.status(200).json({ error: err.message });
    }
  }
});

//user logout
router.get('/logout', async (req, res, next) => {
});

//initial page load select all
router.post('/', async (req, res, next) => {
  var data = req.body; //new
  try {
    var result = await Users.getAll(data); //new
    res.status(200).json(result);
  } catch (err) {
    res.status(200).json({ error : "There are no users." });
  }
});

//create a new user
router.post('/create', middleware.token, async (req, res, next) => {
  var data = req.body;
  delete data.id;
  data.created = data.updated = moment().format().split('T')[0];
  // password convert to hash mode
  data.password = await bcrypt.hash(data.password, saltRounds);
  // insert a new user to user table
  var result = await Users.create(data);
  res.status(200).json(result);
});

//update user
router.post('/update/:id', middleware.token, async (req, res, next) => {
  var id = req.params.id
  var data = req.body;
  delete data.id;
  delete data.password;
  delete data.created;
  data.updated = moment().format().split('T')[0];
  // user update
  try {
    var result = await Users.updateById(id, data);
    res.status(200).json(result);
  } catch(err) {
    res.status(200).json({error: "While updating the information an unexpected error occured."});
  }
});

//delete user
router.post('/delete/:client_id/:id', middleware.token, async (req, res, next) => {
  //find user by id and delete
  try { /* sept 22 2019 david*/
    var result = await Users.deleteById(req.params.client_id, req.params.id);
    res.status(200).json(result);
  } catch(err) {
    res.status(200).json({error: "While updating the information an unexpected error occured."})
  }
});

//myself
router.post('/self', middleware.token, async (req, res, next) => {
  if (req.body.password != "") {
    req.body.password = await bcrypt.hash(req.body.password, saltRounds);
  } else {
    delete req.body.password;
  }
  delete req.body.permission;
  req.body.updated = moment().format().split('T')[0]
  try { 
    var result =  await Users.updateById(req.decoded.data.id, req.body);
    res.status(200).json(result);
  } catch (err) {
    res.status(200).json({ error: "While updating the information an unexpected error occured."})
  }
});

router.post('/workflow', async(req, res, next) => {
  var search = req.body
  var result = await Users.workflow(search);
  if (result) {
    res.status(200).json({
      result: result
    });
  } else {
    res.status(200).json({ error : "There are no new messages." });
  }
});

//create a new schedule
router.post('/createSchedule', middleware.token, async (req, res, next) => {
  var data = req.body;
  delete data.id;
  var result = await Schedules.create(data);
  res.status(200).json(result);
});
//update a schedule
router.post('/updateSchedule', middleware.token, async (req, res, next) => {
  var data = req.body;
  var result = await Schedules.update(data);
  res.status(200).json(result);
});
//copy a schedule
router.post('/copySchedule', middleware.token, async (req, res, next) => {
  var result = await Schedules.copy(req.body.user_id);
  res.status(200).json(result);
});

//get all schedule
router.get('/getSchedule/:id', middleware.token, async (req, res, next) => {
  var result = await Schedules.getSchedule(req.params.id);
  res.status(200).json(result);
});
//get all users
router.get('/getUsers', middleware.token, async (req, res, next) => {
  var result = await Schedules.getUsers();
  res.status(200).json(result);
});
router.post('/deleteSchedule', middleware.token, async (req, res, next) => {
  var result = await Schedules.deleteSchedule(req.body);
  res.status(200).json(result);
});

//create a new schedule
router.post('/createCalendar', middleware.token, async (req, res, next) => {
  var data = req.body;
  delete data.id;
  var result = await Schedules.createCalendar(data);
  res.status(200).json(result);
});
//update a schedule
router.post('/updateCalendar', middleware.token, async (req, res, next) => {
  var data = req.body;
  var result = await Schedules.updateCalendar(data);
  res.status(200).json(result);
});
//copy a schedule
router.post('/copyCalendar', middleware.token, async (req, res, next) => {
  var result = await Schedules.copyCalendar(req.body.user_id);
  res.status(200).json(result);
});

//get all schedule
router.get('/getCalendar/:id', middleware.token, async (req, res, next) => {
  var result = await Schedules.getCalendar(req.params.id);
  res.status(200).json(result);
});
//get all users
router.get('/getUsers', middleware.token, async (req, res, next) => {
  var result = await Schedules.getUsers();
  res.status(200).json(result);
});
//get all users
router.get('/getPatients', middleware.token, async (req, res, next) => {
  var result = await Schedules.getPatients();
  res.status(200).json(result);
});
router.post('/deleteCalendar', middleware.token, async (req, res, next) => {
  var result = await Schedules.deleteCalendar(req.body);
  res.status(200).json(result);
});

module.exports = router;
