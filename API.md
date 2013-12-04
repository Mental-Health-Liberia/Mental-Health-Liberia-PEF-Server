# API

The API can be requested in either JSON or XML format.

`GET /forms.json`

Returns a JSON array of all the forms that are in the database.

`skip` and `limit` parameters can be specified to skip or limit the number of documents returned (per the [find method](http://api.mongodb.org/ruby/1.9.2/Mongo/Collection.html#find-instance_method)).

`POST /forms.json`

Creates a new form with the given POST parameters.

`GET /forms/:id.json`

Returns a JSON object of the form with the id `:id`.
