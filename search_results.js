module.exports= function(){
    var express = require('express');
    var router = express.Router();

    function getRecipesByName(req, res, mysql, context, complete) {
        var query = "SELECT id, name FROM recipes where name=?";
        console.log(req.params);
        var inserts = [req.params.name];
        mysql.pool.query(query, inserts, function(error, results, fields) {
            if(error) {
                res.write(JSON.stringify(error));
                res.end();
            }
            context.recipes = results;
	    console.log(JSON.stringify(context));
	    JSON.stringify(context);
            complete();
        });
    }

    router.get('/keyword_search/:name', function(req, res){
        var callBackCount = 0;
        var context = {};
        context.jsscripts = ["keywordSearch.js"];
        var mysql = req.app.get('mysql');
        getRecipesByName(req, res, mysql, context, complete);
        function complete() {
            callBackCount++;
            if(callBackCount >= 1) {
                res.render('search_results', context)
            }
        }
    });


    //router.get('/filter_search/
    return router;
}();
