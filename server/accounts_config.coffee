Accounts.config {
	sendVerificationEmail: yes

	restrictCreationByEmailDomain: (email)->
		email in [
			'janouma@gmail.com'
			'judicael.anouma@gmail.com'
			'tapelago@yahoo.com'
			'lwanga.anouma@gmail.com'
			'lwanga.anouma@icloud.com'
		]
}

Accounts.emailTemplates.siteName = 'MoneyFlow'

Accounts.emailTemplates.verifyEmail =
	subject: (user)-> I18nEasy.i18n('verifyEmailSubject').replace /#\{email\}/gi, user.emails[0].address
	text: (user, url)-> I18nEasy.i18n('verifyEmailText').replace /#\{url\}/gi, url

Accounts.emailTemplates.enrollAccount =
	subject: (user)-> I18nEasy.i18n('enrollAccountSubject').replace /#\{email\}/gi, user.emails[0].address
	text: (user, url)-> I18nEasy.i18n('enrollAccountText').replace /#\{url\}/gi, url

Accounts.emailTemplates.resetPassword =
	subject: (user)-> I18nEasy.i18n('resetPasswordSubject').replace /#\{email\}/gi, user.emails[0].address
	text: (user, url)-> I18nEasy.i18n('resetPasswordText').replace /#\{url\}/gi, url