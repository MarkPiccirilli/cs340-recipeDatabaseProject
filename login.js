module.exports = function() {
	var express = require('express');
	var router = express.Router();

	console.log('passport test');

	router.post('/login', passport.authenticate('local', {successRedirect: '/index.html', failureRedirect: '/thank_you.html', failureFlash: true}));

	return rounter;
}();


