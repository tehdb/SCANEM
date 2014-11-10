# PWD = process.env.PWD

module.exports = (router, eventEmmiter) ->
	ctrl = require("#{__dirname}/products.ctrl")()

	router
		.route('/store/p/:pid')
		.get( ctrl.selectById )

	router
		.route('/store/insert')
		.post(
			(req, res, next) ->
				console.log "check auth"
				next()
			, ctrl.create
		)

	return router

