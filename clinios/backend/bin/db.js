var mysql = require('mysql2/promise');
var dotenv = require('dotenv');

dotenv.config({path: __dirname + '/../.env'});
var connection = mysql.createPool({
    host: process.env.MYSQL_HOST,
    user: process.env.MYSQL_USERNAME,
    password: process.env.MYSQL_PASSWORD || "",
    database: process.env.MYSQL_DBNAME,
    port: process.env.MYSQL_PORT,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// connection.connect(err => {
//     if (err) throw err;
//     console.log("mysql connected!");
// });


module.exports = connection;