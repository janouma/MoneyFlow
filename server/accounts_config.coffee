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
	subject: (user)-> I18nEasy.i18n('verifyEmailSubject', email: user.emails[0].address)
	text: (user, url)-> I18nEasy.i18n('verifyEmailText', url: url)

Accounts.emailTemplates.enrollAccount =
	subject: (user)-> I18nEasy.i18n('enrollAccountSubject', email: user.emails[0].address)
	text: (user, url)-> I18nEasy.i18n('enrollAccountText', url: url)

Accounts.emailTemplates.resetPassword =
	subject: (user)-> I18nEasy.i18n('resetPasswordSubject', email: user.emails[0].address)
	text: (user, url)-> I18nEasy.i18n('resetPasswordText', url: url)