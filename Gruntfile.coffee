"use strict";

module.exports = (grunt) ->
	require('load-grunt-tasks')(grunt)	# load grunt tasks automatically

	grunt.initConfig
		pkg: grunt.file.readJSON('package.json')

		compass:
			styles:
				options:
				# require: 'sass-globbing'
					sassDir: ".temp/client/"
					cssDir: "public/styles"




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
				extDot: 'last'


		concat:
			scripts:
				options:
					separator: ';'
				src: 	[
					'.temp/client/clientApp.js'	# order important: first app module
					'.temp/client/**/*.mdl.js'	# all modules definitions
					'.temp/client/**/*.js'		# rest
				]
				dest: 	'.temp/client/clientApp.js'

			styles:
				src: [
					'client/scanem.sass'
					'client/layout/**/*.sass'
					'client/**/*.sass'
				]
				dest: '.temp/client/scanem.sass'


		jade:
			templates:
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
			scripts:
				files: ['public/app.js' : '.temp/client/clientApp.js']


		clean:
			build: [ '.temp/client' ]


		mochaTest:
			options:
				reporter: 'spec'
				require: [
					'coffee-script/register'
				]

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


			installDeps:
				command: 'bower install && npm install'

			DummySupply:
				command: 'coffee tools/DummyDataGenerator/_generator.coffee -s'

			DummyClear:
				command: 'coffee tools/DummyDataGenerator/_generator.coffee -c'

		nodemon:
			test:
				script: 'test.js'
				options:
					nodeArgs: ['--debug']
					ext: 'js'
					watch: ['test.js']


			dev:
				script: 'server/serverApp.coffee'
				options:
					ext: 'coffee,jade,json'
					watch: ['server/**/*']
			debug:
				script: 'server/serverApp.coffee'
				options:
					nodeArgs: ['--nodejs', '--debug']
					ext: 'coffee,jade,json'
					watch: ['server/**/*']


		'node-inspector':
			debug: {}


		concurrent:
			dev:
				tasks: ['nodemon:dev']
				options:
					logConcurrentOutput: true

			debug:
				tasks: ['nodemon:debug', 'node-inspector']
				options:
					logConcurrentOutput: true

		watch:
			options:
				livereload: true
			scripts:
				files: [ 'client/**/*.coffee', 'client/**/*.jade' ]
				tasks: [ 'client-build-scripts' ]

			styles:
				files: ['client/**/*.sass' ]
				tasks: [ 'client-build-styles' ]


			server_unit_tests:
				files: ['tests/server/unit/**/*.spec.coffee']
				tasks: ['mochaTest:unit']

			api_tests:
				options: { debounceDelay: 500 }
				files: ['tests/server/api/**/*.spec.coffee']
				tasks: ['mochaTest:api']


	grunt
		.registerTask( 'client-build', [
			'clean:build'
			'client-build-styles'
			'client-build-scripts'
			'clean:build'
		])

		.registerTask( 'dummy-supply', ['exec:DummySupply'])
		.registerTask( 'dummy-clear', ['exec:DummyClear'])

		.registerTask( 'client-build-styles', [
			'concat:styles'
			'compass:styles'
		])
		.registerTask( 'client-build-scripts', [
			'jade:inline'
			'jade:templates'
			'coffee:client'
			'concat:scripts'
			'includes:inline'
			'copy:scripts'
		])
		.registerTask( 'client-test', 		[ 'karma' ])

		.registerTask( 'server-start', 		[ 'exec:server'] )
		.registerTask( 'start', 			[ 'concurrent:dev'] )
		.registerTask( 'debug', 			[ 'concurrent:debug'] )
		.registerTask( 'server-test-e2e', 	[ 'mochaTest:api' ] )
		.registerTask( 'server-test-unit',  [ 'mochaTest:unit'] )

		.registerTask( 'prerender-start', 	[ 'exec:prerender' ])

		.registerTask( 'default', [
			'exec:installDeps'
			'client-build-styles'
			'client-build-scripts'
			'server-start'
		])




