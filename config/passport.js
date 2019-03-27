

passport.use(new LocalStrategy(
    function(username, password, done) {
        username.findOne({username:username}, function(err, user) {
            if(err) {
                return done(err);
            }
            if(!user) {
                return done(null,false, {message: 'Username not found'});
            }
            if(!user.validPassword(password)) {
                return done(null, false, {message: 'Incorrect Password'})
            }
            return done(null, user);
        });
    }
));