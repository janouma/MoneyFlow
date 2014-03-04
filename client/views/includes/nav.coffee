templateName = 'nav'

toKey = (message)-> message?.replace(/\W*/g, '').toLowerCase()

#===============================
translateLoginWidget = ->
	recurrentTranslations = {
		email: I18nEasy.i18n('email')
		changePassword: I18nEasy.i18n('changePassword')
		with: I18nEasy.i18n('with')
	}

	signInKey = 'signin'
	createAccountKey = 'createaccount'

	recurrentTranslations[signInKey] = I18nEasy.i18n signInKey
	recurrentTranslations[createAccountKey] = I18nEasy.i18n createAccountKey

	$(@find "#login-email").attr(placeholder: recurrentTranslations.email)
	$(@find "#forgot-password-email").attr(placeholder: recurrentTranslations.email)
	$(@find "#login-old-password").attr(placeholder: I18nEasy.i18n('currentPassword'))

	if @find '#login-old-password'
		$(@find "#login-password").attr(placeholder: I18nEasy.i18n('newPassword'))
	else
		$(@find "#login-password").attr(placeholder: I18nEasy.i18n('password'))

	$(@find ".login-close-text").text I18nEasy.i18n('close')
	$(@find ".sign-in-text-google").text "#{recurrentTranslations[signInKey]} #{recurrentTranslations.with} google"
	$(@find ".sign-in-text-twitter").text "#{recurrentTranslations[signInKey]} #{recurrentTranslations.with} twitter"
	$(@find ".or-text").text I18nEasy.i18n('or')
	$(@find "#signup-link").text recurrentTranslations[createAccountKey]
	$(@find "#forgot-password-link").text I18nEasy.i18n('forgotPassword')
	$(@find "#back-to-login-link").text recurrentTranslations[signInKey]
	$(@find "#login-buttons-open-change-password").text recurrentTranslations.changePassword
	$(@find "#login-buttons-do-change-password").text recurrentTranslations.changePassword
	$(@find "#login-buttons-logout").text I18nEasy.i18n('signout')
	$(@find "#login-buttons-forgot-password").text(I18nEasy.i18n('reset'))

	$actionButton = $(@find "#login-buttons-password")
	actionButtonKey = toKey $actionButton.text()

	switch actionButtonKey
		when signInKey
			$actionButton.text recurrentTranslations[signInKey]
			$actionButton
				.removeClass('fa-user')
				.addClass('fa-sign-in')

		when createAccountKey
			$actionButton.text recurrentTranslations[createAccountKey]
			$actionButton
				.removeClass('fa-sign-in')
				.addClass('fa-user')

	invalidUserNameLengthKey = 'usernamemustbeatleast3characterslong'
	incorrectPasswordKey = 'incorrectpassword'
	invalidEmailKey = 'invalidemail'
	internalServerErrorKey = 'internalservererror'
	userNotFoundKey = 'usernotfound'
	passwordToShortKey = 'passwordmustbeatleast6characterslong'
	emailConflictKey = 'emailalreadyexists'
	unauthorizedEmailKey = 'emaildoesntmatchthecriteria'

	$errorMessage = $(@find ".error-message")
	errorMessageKey = toKey $errorMessage.text()

	$errorMessage.text(
		switch errorMessageKey
			when invalidEmailKey then I18nEasy.i18n(invalidEmailKey)
			when internalServerErrorKey then I18nEasy.i18n(internalServerErrorKey)
			when invalidUserNameLengthKey then I18nEasy.i18n(invalidUserNameLengthKey)
			when incorrectPasswordKey then I18nEasy.i18n(incorrectPasswordKey)
			when userNotFoundKey then I18nEasy.i18n(userNotFoundKey)
			when passwordToShortKey then I18nEasy.i18n(passwordToShortKey)
			when emailConflictKey then I18nEasy.i18n(emailConflictKey)
			when unauthorizedEmailKey then I18nEasy.i18n(unauthorizedEmailKey)
	)

	emailSentKey = 'emailsent'
	passwordChangedKey = 'passwordchanged'

	$infoMessage = $(@find ".info-message")
	infoMessageKey = toKey $infoMessage.text()

	$infoMessage.text(
		switch infoMessageKey
			when emailSentKey then I18nEasy.i18n(emailSentKey)
			when passwordChangedKey then I18nEasy.i18n(passwordChangedKey)
	)



#===============================
Template[templateName].helpers {
    activeRouteClass: (routeNames...)->
        activeRoutePattern = new RegExp "^(\w{2}\/)?#{Router.current().route.name}\/?"
        # routeNames[0...] gets rid of the hash added by handlebars
        return 'active' for route in routeNames[0...] when activeRoutePattern.test route
}

#===============================
Template[templateName].rendered = ->
	Meteor.defer =>
		if Meteor.user()
			$(@find '#login-name-link').html("<i class='fa fa-user'></i> <span class='login-menu-item'>#{Meteor.user().emails?[0]?.address}</span>")
		else
			$(@find "#login-sign-in-link").html("<i class='fa fa-chevron-down'></i> <span class='login-menu-item'>#{I18nEasy.i18n 'signin'}</span>")

		$loginWrapper = $(@find ".login-wrapper")

		if @find("#login-dropdown-list")
			translateLoginWidget.call(@)
			$loginWrapper.removeClass('closed')
		else
			$loginWrapper.addClass('closed')

		$("#just-verified-dismiss-button").parent()
			.html("""<div class='message info-message'>#{I18nEasy.i18n 'verifiedEmail'}</div>
<div class='login-button' id='just-verified-dismiss-button'><i class='fa fa-times'></i> #{I18nEasy.i18n 'hidde'}</div>""")
			.css {
				visibility: 'visible'
				opacity: 1
			}