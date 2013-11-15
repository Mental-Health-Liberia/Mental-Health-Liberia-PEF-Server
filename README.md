# Mental Health Liberia - Server
This is the server backend for the [web frontend](https://github.com/Tanner/Mental-Health-Liberia-PEF-Client).

It serves an API to allow both the web frontend and a data dashboard. The data dashboard is another team in the same C4G class. This server does not directly serve the front end.

## Background
This project is a part of the Computing for Good class led by [Ellen Zegura](http://www.cc.gatech.edu/~ewz/Welcome.html) at the [Georgia Institute of Technology](http://www.gatech.edu).

## Installation
The server requires the following software packages to be installed:
 - [Ruby](https://www.ruby-lang.org/en/)
 - [RubyGems](http://rubygems.org/) 
 - [MongoDB](http://www.mongodb.org/) (if you're on OS X, use [Homebrew](http://brew.sh/) to install via `brew install mongo`.)

Once installed, run `bundle` in the repo's main directory.

To run the server start MongoDB by running `mongod`, then running `rails server`.

### Running with the Web Frontend
If you want to run both the server and the [web frontend](https://github.com/Tanner/Mental-Health-Liberia-PEF-Client), there are a few more steps required.

1. Clone the [web frontend repository](https://github.com/Tanner/Mental-Health-Liberia-PEF-Client) to a convienent location.
2. Follow the instructions for the web frontend to build a the static site.
3. In the `public/` directory in the server app, make a symbolic link to the web frontend directory, i.e. `ln -s front-end-path dist`.
4. Once that is done, start the server and go to `0.0.0.0:3000/dist/` to view the client app and submit forms.

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
* Alex Satterly
