module.exports = function() {
    var express = require('express');
    var router = express.Router();

    router.post('/contributeRecipe', function(req, res) {
	console.log(req.body);
	var mysql = req.app.get('mysql');
	var sql = "INSERT INTO recipes (name, instructions, meal_type, ethnic_cuisine, servings, contributor, date_contributed) VALUES (?, ?, ?, ?, ?, ?, ?)";
	var inserts = [req.body.name, req.body.instructions, rec.body.meal_type, rec.body.ethnic_cuisine, rec.body.servings, rec.body.contributor, rec.body.date_contributed];
	sql = mysql.pool.query(sql,inserts,function(error, result, fields) {
	    if(error) {
		console.log(JSON.stringify(error));
		res.write(JSON.stringify(error));
		res.end();
	    }
	    else {
		res.render('thank_you');
	    }
	});
    });

    return router;
}();



