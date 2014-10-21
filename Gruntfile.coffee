"use strict";

module.exports = (grunt) ->
	require('load-grunt-tasks')(grunt)	# load grunt tasks automatically

	grunt.initConfig
		pkg: grunt.file.readJSON('package.json')


		coffee:
			options:
				bare: true
				join: false
				sourceMap: false

			client:
				expand: true,
				flatten: false,
				cwd: 'client'
				src: ['**/*.coffee']
				dest: '.temp/client'
				ext: '.js'


		concat:
			options:
				separator: ';'
			scripts:
				src: 	[
					'.temp/client/clientApp.js'
					'.temp/client/**/*.js'
				]
				dest: 	'.temp/client/clientApp.js'


		jade:
			views:
				cwd: 	'client/'
				src: 	['**/*.tpl.jade', '!**/*.inl.tpl.jade']
				dest: 	'public/partials'
				expand: true
				ext: 	'.html'

			inline:
				cwd: 	'client/'
				src: 	'**/*.inl.tpl.jade'
				dest: 	'.temp/client'
				expand: true
				ext: 	''


		includes:
			inline:
				options:
					includeRegexp: /['"]\[\[([^'"]+)\]\]['"]/
					debug: true
				files: [ '.temp/client/clientApp.js' : '.temp/client/clientApp.js' ]


		copy:
			client:
				files: ['public/app.js' : '.temp/client/clientApp.js']


		watch:
			clientApp:
				files: [ 'client/**/*.coffee', 'client/**/*.jade' ]
				tasks: [ 'client-build' ]
				options:
					livereload: true

			# templates:
			# 	files: [ 'client/**/*.tpl.jade' ]
			# 	tasks: [ 'jade:views' ]
			# 	options:
			# 		livereload: true


			server_unit_tests:
				files: ['tests/server/unit/**/*.spec.coffee']
				tasks: ['mochaTest:unit']

			api_tests:
				options: { debounceDelay: 500 }
				files: ['tests/server/api/**/*.spec.coffee']
				tasks: ['mochaTest:api']


		mochaTest:
			options:
				reporter: 'spec'
				require: 'coffee-script/register'

			unit:
				src: ['tests/server/unit/**/*.spec.coffee']

			api:
				src: ['tests/server/api/**/*.spec.coffee']


		karma:
			client:
				configFile: 'karma.conf.coffee'


		exec:
			prerender:
				command: 'nodemon prerender.coffee'

			server:
				command: 'nodemon server/serverApp.coffee'

	grunt
		.registerTask( 'client-build', 		[ 'coffee:client', 'concat:scripts', 'jade:inline', 'includes:inline', 'copy:client', 'jade:views' ])
		.registerTask( 'client-watch', 		[ 'watch:clientApp' ])
		.registerTask( 'client-test', 		[ 'karma' ])
		.registerTask( 'server-start', 		[ 'exec:server'] )
		.registerTask( 'server-test-e2e', 	[ 'mochaTest:api' ] )
		.registerTask( 'server-test-unit',  [ 'mochaTest:unit'] )
		.registerTask( 'watch_unit_tests', 	[ 'watch:server_unit_tests' ])
		.registerTask( 'watch_api_tests', 	[ 'watch:api_tests' ])
		.registerTask( 'prerender-start', 	[ 'exec:prerender' ])
		.registerTask( 'default', [] )




