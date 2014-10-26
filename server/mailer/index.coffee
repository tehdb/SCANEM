
# PWD = process.env.PWD

nodemailer = require("nodemailer")
jade = require('jade')
fs = require('fs')

# _smtpTransport = nodemailer.createTransport "SMTP",
# 	host: 'flavity.de'
# 	# secureConnection: true,
# 	port: 25
# 	auth:
# 		user: 'support@flavity.de'
# 		pass: 'fl@v1t7$1000'


_sendVerifyEmail = (userData) ->
	console.log userData
	# tpl = './verify.tpl.jade'
	# vm =
	# 	title: 		req.i18n.t('labels.verify_email')
	# 	header: 	req.i18n.t('labels.thank_for_registration')
	# 	linklabel: 	req.i18n.t('labels.click_to_verify_email')
	# 	verifylink: "http://localhost:3030/verify/#{userData.token}"


	# fs.readFile tpl, 'utf8', ( err, template ) ->
	# 	return _callback( err ) if err
	# 	html = jade.compile( template )(vm)
	# 	_smtpTransport.sendMail
	# 		from: 		'support@flavity.de'
	# 		to: 		userData.email
	# 		subject: 	vm.title
	# 		html: 		html
	# 	, ( err, res ) ->
	# 		return callback?( err ) if err
	# 		_smtpTransport.close()
	# 		callback?( null, true )



module.exports = ( pubsub, logger ) ->
	pubsub.on 'UserCreatedEvent', (user) -> _sendVerifyEmail(user, logger)



	pubsub.on 'UserVerifiedEvent', (user) ->
