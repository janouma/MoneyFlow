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