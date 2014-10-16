
router = require('express').Router()

usersCtrl = require('../controllers/users.ctrl')

# users routes
router
	.route('/users/:type?/:query?')
	.get( 	usersCtrl.select )
	.post( 	usersCtrl.insert )
	.put( 	usersCtrl.update )


module.exports = router


