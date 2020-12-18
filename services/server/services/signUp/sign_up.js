var config = require('../../../config/init');
const bcrypt = require('bcrypt');
const login = require('../login/login');

function registerNewUser(data, error, success) {

   const { email, password } = data;
  
    bcrypt.hash(password, config.saltRounds, function(err, hashPassword) {
        console.log(login);
        config.dbPool.query('INSERT INTO users (email, password) VALUES ($1, $2)', 
          [email, hashPassword], (fail, results) => {
            if (fail) {
                error(fail.detail);
                return;
            }
            success();
        });  
    });

}

module.exports = {
    registerNewUser,
}