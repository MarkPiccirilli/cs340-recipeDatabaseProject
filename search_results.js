module.exports = function() {
    var express = require('express');
    var router = express.Router

    function getRecipesByName(req, res, mysql, context, complete) {
        var query = "SELECT id FROM recipes where name=?";
        console.log(req.params)
        var inserts = [req.params.name]
        mysql.pool.query(query, inserets, function(error, results, fields) {
            if(error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.recipes = results;
            complete();
        });
    }
    router.get('/search/:name', function(req, res){
        var callBackCount = 0;
        var context = {};
        context.jsscripts = ["recipe_name_search.js"];
        var mysql = req.app.get('mysql');
        getRecipesByName(req, res, mysql, context, complete);
        function complete() {
            callBackCount++;
            if(callBackCount >= 1) {
                res.render('search_results', context)
            }
        }
    });
}(); //end module.exports = function()
