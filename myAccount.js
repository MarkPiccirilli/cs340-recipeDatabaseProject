module.exports = function() {
    var express = require('express');
	var router = express.Router();

	
	function checkAuthentication(req, res, next) {
		if(req.isAuthenticated()) {
			next();
		}
		else {
			res.redirect('/login.html');
		}
	}
	

    function getMyAccountInfoById(req, res, mysql, context, complete) {
	var query = "SELECT first_name, last_name, user_name, email, cooking_experience FROM users WHERE id=?";
	console.log(req.params);
	//console.log('uid: ' + req.user.id);
	var inserts = [req.params.id];
	//var inserts = [req.session.passport.user.id];
	//console.log(req.session.passport.user.id);
	mysql.pool.query(query, inserts, function(error, results, fields) {
	    if(error) {
		res.write(JSON.stringify(error));
		res.end();
	    }
	    context.myAccountInfo = results;
	    console.log(JSON.stringify(context));
	    JSON.stringify(context);
	    complete();
	});
    }

    router.get('/my_account/:id', checkAuthentication, function(req, res) {
	var callBackCount = 0;
	var context = {};
	var mysql = req.app.get('mysql');
	getMyAccountInfoById(req, res, mysql, context, complete);
	function complete() {
	    callBackCount++;
	    if(callBackCount >= 1) {
		res.render('myAccount', context);
	    }
	}
    });

    return router;
}();
