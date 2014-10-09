## JavaScript WorkShop at 07 - 09.10.2014

Content
http://www.it-schulungen.com/seminare/softwareentwicklung/javascript/javascript-fortgeschrittene-programmierung.html

## Project Thema:
A mini app that enable search profile data into backend. 

Demo: http://localhost:3030/

Client: AngularJS
- Search in profiles

Server: Node.js
- WS Profile CRUD
- WS Profile Search

data structure
[{
	name: 'String',
	surname: 'String',
	email: 'String'
}]


## Server
	- start server: $ nodemon server/app.coffee

## API

	# p - search by property
	# q - search string
	# m - max result entries. -1 to get all
	# s - sort by property

	Get all entries that contain 'Adam', sorted by surname
	example: http://localhost:3030/api/users?q=Adam&s=surname&m=-1

## SEO
	start prerender server: 	$ grunt prerender-start
	test prerender:				http://localhost:3030/?_escaped_fragment_=


## Tests
	watch and run unit tests: 	$ grunt watch_unit_tests
	watch and run angular test: $ grunt client-test

## Global npm modules
	$ npm install -g grunt-cli        # JavaScript task runner (http://gruntjs.com)
	$ npm install -g coffee-script    # better JavaScript (http://coffeescript.org)
	$ npm install -g forever          # continuously running tool (https://github.com/nodejitsu/forever)
	$ npm install -g mocha            # feature-rich JavaScript test framework (http://visionmedia.github.io/mocha/)

## Intall
	$ git clone https://github.com/cbaeza/jsworkshop.git # clone repository
	$ cd jsworkshop
	$ npm install # install node.js dependencies
	$ bower install # install frontend dependencies
	$ grunt client-build # compile client
	$ nodemon server/app.coffee


