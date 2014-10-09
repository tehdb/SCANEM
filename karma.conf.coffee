module.exports = (config) ->
	config.set
		basePath: ''
		frameworks: ['mocha', 'chai']
		# frameworks: ['mocha', 'sinon-chai']
		files: [
			'bower_components/angular/angular.js'
			'bower_components/angular-route/angular-route.js'
			'bower_components/angular-mocks/angular-mocks.js'
			'tests/client/test-main.coffee'
			'public/app.js'
			#'tests/client/**/*.coffee'
		]
		plugins: [
			'karma-mocha'
			'karma-chai'
			'karma-chrome-launcher'
			'karma-coffee-preprocessor'
		]
		exclude: []
		preprocessors:
			'**/*.coffee': ['coffee']
		reporters: [
			'progress'
		]
		port: 9876
		colors: true
		logLevel: config.LOG_INFO
		autoWatch: true
		browsers: [
			'Chrome'
			# 'PhantomJS'
		]
		singleRun: false
