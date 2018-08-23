
var express = require('express');
var mysql = require('./dbcon.js');
var bodyParser = require('body-parser');

var app = express();
var handlebars = require('express-handlebars').create({defaultLayout:'main'});

app.engine('handlebars', handlebars.engine);
app.use(bodyParser.urlencoded({extended:true}));
app.use('/static', express.static('public'));
app.set('view engine', 'handlebars');
app.set('port', process.argv[2]);
app.set('mysql', mysql);
app.use('/', require('./search_results.js'));
app.use('/', require('./recipe_display.js'));
app.use('/', require('./contributor.js'));
//app.use('/', require('./contribute_recipe.js'));
app.use('/', require('./createAccount.js'));
app.use('/', require('./myAccount.js'));
app.use('/', express.static('public'));

/*
    app.post('/', function(req, res) {
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
		res.redirect('/thank_you');
	    }
	});
    });
*/
app.use(function(req,res) {
    res.status(404);
    res.render('404');
});

app.use(function(err, req, res, next) {
    console.error(err.stack);
    res.status(500);
    res.render('500');
});

app.listen(app.get('port'), function(){
    console.log('Express started on http://flip1.engr.oregonstate.edu:' + app.get('port') + '; press Ctrl-C to terminate.');
});
