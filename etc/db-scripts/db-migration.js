/**
 * This mongo script alters the database, and replaces the field "script" by "scripts"
 */
db.App.find({}).forEach(function(app) {

	app.scripts = [ { "_id" : "main.js", "source" : app.script, "type" : "JAVASCRIPT", "apiVersion" : "v1" } ] ;
	delete app.script;

	db.App.save(app);
});
