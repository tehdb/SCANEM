_ = require('lodash')
router = require('express').Router()

User = require('../models/user.mdl')

router
	.route('/Metadata')
	.get (req, res) ->
		res.status(400).send("no metadata")

# /api/users/type/query
router
	.route('/users/:type?/:query?')

	# SELECT
	.get (req,res) ->

		if req.params.type and req.params.query
			propertyName = req.params.type
			switch propertyName
				when 'id' then propertyName = "_#{propertyName}"

			filter = {}
			filter[propertyName] = req.params.query

			User.findOne filter, (err, user) ->
				return res.status(400).send( err ) if err
				res.json( user )

		else
			User.find (err, users) ->
				return res.status(400).send( err ) if err
				res.json( users )

	# INSERT
	.post (req,res) ->
		user = new User( req.body )
		user.save (err) ->
			return res.status(400).send( err ) if err
			res.json( user )

	# UPDATE
	.put (req, res) ->
		User.findOne {_id: req.body._id}, (err, user) ->
			return res.status(400).send( err ) if err

			user = _.assign( user, req.body )

			user.save (err, user) ->
				return res.status(400).send( err ) if err

				res.json( user )



module.exports = router

