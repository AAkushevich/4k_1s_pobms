
let tokenKey = {
    key: 'localhost',
};

const Pool = require('pg').Pool
const pool = new Pool({
  user: 'postgres',
  host: '127.0.0.1',
  database: 'spa_db',
  password: 'qwerty',
  port: 5432,
});


const saltRounds = 10;


module.exports = {
    tokenKey: tokenKey,
    dbPool: pool,
    saltRounds: saltRounds,
};