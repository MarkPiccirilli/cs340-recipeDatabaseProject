document.addEventListener('DOMContentLoaded', myaccount);
console.log('test');

function myaccount() {
    document.getElementById('myAccountLink').addEventListener('click', function() {
        //console.log(req.session.passport.user.id);
        //window.location = '/myAccount/' + req.session.passport.user.id;
        window.location = '';
    });
}