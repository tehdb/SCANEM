PWD = process.env.PWD

module.exports = (router, eventEmmiter) ->
	ctrl = require("#{__dirname}/products.ctrl")()

	router
		.route('/store/p/:pid')
		.get( ctrl.selectById )

