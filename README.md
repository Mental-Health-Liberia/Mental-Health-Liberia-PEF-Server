# Mental Health Liberia - Client
This is the server backend for the [web frontend](https://github.com/Tanner/Mental-Health-Liberia-PEF-Client).

It serves an API to allow both the web frontend and a data dashboard. The data dashboard is another team in the same C4G class. This server does not directly serve the front end.

## Background
This project is a part of the Computing for Good class led by [Ellen Zegura](http://www.cc.gatech.edu/~ewz/Welcome.html) at the [Georgia Institute of Technology](http://www.gatech.edu).

## API
The API can be requested in either JSON or XML format.

`GET /forms.json`

Returns a JSON array of all the forms that are in the database.

`POST /forms.json`

Creates a new form with the given POST parameters.

`GET /forms/:id.json`

Returns a JSON object of the form with the id `:id`.

### Group Members
* Ryan Ashcraft
* Tanner Smith
* John Dugan
* Alex Saterly