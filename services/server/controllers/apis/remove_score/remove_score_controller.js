const
    express = require('express'),
    removeScoreService = require('../../../services/removeScore/remove_score');

let router = express.Router();

router.get('/', (request, response) => {

    function error(message) {
        response.status(400).send({
            status: "error",
            msg: message
        });
    }

    function success() {
        response.status(200).send({
            status: "success",
        });
    }

    removeScoreService.removeScore(request, error, success);
});

module.exports = router;