modules.exports = function() {
    var express = require('express');
    var router = express.Router();

    function getMyAccountInfoById(req, res, mysql, context, complete) {
	var query = "SELECT first_name, last_name, user_name, email, cooking_experience FROM users WHERE id=?;";
	console.log(req.params);
	var inserts = [req.params.id];
	mysql.pool.query(query, inserts, function(error, results, fields) {
	    if(error) {
		res.write(JSON.stringify(error));
		res.end();
	    }
	    context.myAccoutInfo = results;
	    console.log(JSON.stringify(context));
	    JSON.stringify(context);
	    complete();
	});
    }

    router.get('/my_account/:id', function(req, res) {
	var callBackCount = 0;
	var context = {};
	var mysql = req.app.get('mysql');
	getMyAccountInfoById(req, res, mysql, context, complete);
	function complete() {
	    callBackCount++;
	    if(callBackCount >= 2) {
		res.render('account', context)
	    }
	}
    });

    return router;
}();
