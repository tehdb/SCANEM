
# root = process.env.root
root = global.CONF().root

nodemailer = require("nodemailer")
jade = require('jade')
fs = require('fs')

_transporter = nodemailer.createTransport()

_sendVerifyEmail = (userData, i18n, logger) ->

	# console.log "*******"
	# console.log i18n.__('labels.test')
	# console.log "*******"

	# console.log userData
	tpl = "#{root}/server/mailer/verify.tpl.jade"
	vm =
		title: 		i18n.__('verify_email_title')
		linklabel: 	i18n.__('verify_link_label')
		verifylink: "http://localhost:3030/verify/#{userData.token}" # TODO: pass domain


	fs.readFile tpl, 'utf8', ( err, template ) ->
		return console.log( err ) if err

		html = jade.compile( template )(vm)

		# console.log "send email"
		# console.log html
		# _smtpTransport.sendMail
		# 	from: 		'sender@address'
		# 	to: 		userData.email
		# 	subject: 	vm.title
		# 	html: 		html
		# , ( err, res ) ->
		# 	return callback?( err ) if err
		# 	_smtpTransport.close()
		# 	callback?( null, true )



module.exports = ( pubsub, i18n, logger ) ->
	pubsub.on 'UserCreatedEvent', (user) -> _sendVerifyEmail(user, i18n, logger)



	pubsub.on 'UserVerifiedEvent', (user) ->
