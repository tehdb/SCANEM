## SCANEM

S - sass
C - coffee-script
A - angular
N - node
E - express
M - mongo



## Server
	- start server: $ nodemon server/app.coffee



## SEO
	start prerender server: 	$ grunt prerender-start
	test prerender:				http://localhost:3030/?_escaped_fragment_=


## Tests
	watch and run unit tests: 	$ grunt watch_unit_tests
	watch and run angular test: $ grunt client-test

## Prerequisites

### global npm modules
```bash
	$ npm install -g grunt-cli        # JavaScript task runner (http://gruntjs.com)
	$ npm install -g coffee-script    # better JavaScript (http://coffeescript.org)
	$ npm install -g forever          # continuously running tool (https://github.com/nodejitsu/forever)
	$ npm install -g mocha            # feature-rich JavaScript test framework (http://visionmedia.github.io/mocha/)
```

### local installation
	$ https://github.com/tehdb/MEAN-CS.git
	$ cd jsworkshop
	$ npm install # install node.js dependencies
	$ bower install # install frontend dependencies
	$ grunt client-build # compile client
	$ nodemon server/app.coffee
