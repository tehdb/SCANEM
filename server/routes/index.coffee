
router = require('express').Router()

usersCtrl = require('../controllers/users.ctrl')
i18nCtrl = require('../controllers/i18n.ctrl')

# users routes
router
	.route('/users/:type?/:query?')
	.get( 	usersCtrl.select )
	.post( 	usersCtrl.insert )
	.put( 	usersCtrl.update )


# i18n routes
router
	.route('/i18n/:langs?')
	.get( i18nCtrl.get )

module.exports = router


