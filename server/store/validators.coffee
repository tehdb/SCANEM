_ = require('lodash')

module.exports =
	price: (val) ->
		valid = true

		codes = [
			'EUR'
			'GBP'
			'RUB'
		]

		return false if !_.isObject( val )

		return false if !_.isNumber( val.amount ) or val.amount <= 0

		return false if !_.isString( val.currency ) or !_.find codes, (c) -> return c is val.currency

		return valid

	color: (val) ->
		valid = true
		for k, v of val
			return false if !_.isNumber(v) or v < 0 or v > 255

		val.r = val.r || 0
		val.g = val.g || 0
		val.b = val.b || 0

		return true

