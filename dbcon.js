var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_piccirim',
  password        : '1946',
  database        : 'cs340_piccirim'
});
module.exports.pool = pool;
