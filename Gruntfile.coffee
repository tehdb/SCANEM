"use strict";

module.exports = (grunt) ->
	require('load-grunt-tasks')(grunt)	# load grunt tasks automatically


	coffee:
		options:
			bare: true
			join: false
			sourceMap: false


		client:
			expand: true,
			flatten: false,
			cwd: 'client/scripts'
			src: ['**/*.coffee']
			dest: '.temp/client'
			ext: '.js'
