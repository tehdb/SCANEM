
# router = require('express').Router()

# usersCtrl = require('../controllers/users.ctrl')
# i18nCtrl = require('../controllers/i18n.ctrl')

# # users routes
# router.route('/users/:type?/:query?')
# 	.get( 	usersCtrl.select )
# 	.post( 	usersCtrl.insert )
# 	.put( 	usersCtrl.update )

# # router.route('/user/')
# # 	.post( )	# create user
# # 	.put( )		# update user


# # router.route('/user/auth')
# 	# .post()		# autenticate user


# # i18n routes
# router
# 	.route('/i18n/:langs?')
# 	.get( i18nCtrl.get )

# module.exports = router



router = require('express').Router()
fs = require('fs')
path = require('path')


# inti routs
fs.readdirSync( __dirname ).forEach ( file ) ->
	modulePath = "#{__dirname}/#{file}"
	stats = fs.statSync( modulePath )
	if stats.isDirectory()
		require( "#{modulePath}/#{file}.rt" )(router)

module.exports = router


