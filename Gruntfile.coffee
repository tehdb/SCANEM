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

	grunt
		.registerTask( 'client-build', [
			'coffee:client'
			'concat:scripts'
		])

		.registerTask( 'client-watch', [
			'watch:client'
		])

		.registerTask( 'default', [] )



