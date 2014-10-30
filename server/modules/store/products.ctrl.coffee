
module.exports = () ->
	return x =
		selectById: (req, res, next) ->
			pid = req.params.pid

			res.send( pid )

