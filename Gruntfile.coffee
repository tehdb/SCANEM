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
					'.temp/client/app.js'
					'.temp/client/**/*.js'
				]
				dest: 	'public/app.js'

		watch:
			client :
				files : [
					'client/**/*.coffee'
				]
				tasks: [ 'client-build' ]
				options:
					livereload: true

			server_unit_test:
				files: ['tests/server/unit/**/*.spec.coffee']
				tasks: ['mochaTest:unit']

		mochaTest:
			unit:
				options:
					reporter: 'spec'
					require: 'coffee-script/register'
				src: ['tests/server/unit/**/*.spec.coffee']

		karma:
			client:

		exec:
			prerender:
				command: 'nodemon prerender.coffee'

	grunt
		.registerTask( 'client-build', 		[ 'coffee:client', 'concat:scripts' ])
		.registerTask( 'client-watch', 		[ 'watch:client' ])
		.registerTask( 'karma', 			[ 'karma'])
		.registerTask( 'server-test', 		[ 'mochaTest:unit' ])
		.registerTask( 'prerender-start', 	[ 'exec:prerender' ])
		.registerTask( 'default', [] )




