
var express = require('express');
var mysql = require('./dbcon.js');
var bodyParser = require('body-parser');
var session = require('express-session');
var flash = require('connect-flash');


var app = express();
var handlebars = require('express-handlebars').create({defaultLayout:'main'});

app.use(bodyParser.urlencoded({extended:false}));

var passport = require('passport');
var LocalStrategy = require('passport-local').Strategy;
passport.use(new LocalStrategy(//{usernameField: 'user_name', passwordField: 'user_password'}, 
	function(username, password, done) {
		if(!username || !password) {
			console.log('username and password required');
			return done(null, false, {message: 'Username and Password required'});
		}
		//var mysql = req.app.get('mysql');
		sql = 'SELECT * FROM users WHERE user_name = ?';  

        mysql.pool.query(sql, [username], function(err, user) {
			console.log(user);
            if(err) {
				console.log('err');
                return done(err);
            }
            if(!user[0]) {
				console.log('username not found');
                return done(null,false, {message: 'Username not found'});
			}
			//console.log("up: " + user[0].user_password);
			//console.log('p: ' + password);
			//console.log(password.localeCompare(user[0].user_password));
            if(password.localeCompare(user[0].user_password)) {
				console.log('incorrect password');
                return done(null, false, {message: 'Incorrect Password'})
			}
			console.log('correct!');
            return done(null, user[0]);
        });
    }
));

passport.serializeUser(function(user, done) {
	done(null, user.id);
});

passport.deserializeUser(function(id, done) {
	sql = 'SELECT * FROM users WHERE id = ?';
	mysql.pool.query(sql, [id], function(err, user) {
		done(err, user);
	});
});

app.engine('handlebars', handlebars.engine);

app.use(session({ secret:'Leo' , resave: true, saveUninitialized: true}));
app.use(flash());
app.use(passport.initialize());
app.use(passport.session());
app.use('/static', express.static('public'));
app.set('view engine', 'handlebars');
app.set('port', 3000);
app.set('mysql', mysql);
app.use('/', require('./search_results.js'));
app.use('/', require('./recipe_display.js'));
app.use('/', require('./contributor.js'));
//app.use('/', require('./contribute_recipe.js'));
app.use('/', require('./createAccount.js'));
app.use('/', require('./myAccount.js'));
//app.use('/', require('./login.js'));
app.post('/login', passport.authenticate('local', {successRedirect: '/index.html', failureRedirect: '/login.html', failureFlash: true}));
//app.get('/login', function(req,res){res.render('')});
app.use('/', express.static('public'));

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
    console.log('Express started on http://localhost:' + app.get('port') + '; press Ctrl-C to terminate.');
});
