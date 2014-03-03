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
	$(@find "#just-verified-dismiss-button").parent().html "#{I18nEasy.i18n 'verifiedEmail'} <div class='btn btn-warning' id='just-verified-dismiss-button'>#{I18nEasy.i18n 'hidde'}</div>"

	$actionButton = $(@find "#login-buttons-password")
	actionButtonKey = toKey $actionButton.text()

	if recurrentTranslations[signInKey] isnt $actionButton.text() and actionButtonKey is signInKey
		$actionButton.text recurrentTranslations[signInKey]
		$actionButton.removeClass('fa-user')
			.addClass('fa-sign-in')

	if recurrentTranslations[createAccountKey] isnt $actionButton.text() and actionButtonKey is createAccountKey
		$actionButton.text recurrentTranslations[createAccountKey]
		$actionButton.removeClass('fa-sign-in')
			.addClass('fa-user')

	invalidUserNameLengthKey = 'usernamemustbeatleast3characterslong'
	incorrectPasswordKey = 'incorrectpassword'
	invalidEmailKey = 'invalidemail'
	internalServerErrorKey = 'internalservererror'
	userNotFoundKey = 'usernotfound'

	recurrentTranslations[invalidUserNameLengthKey] = I18nEasy.i18n invalidUserNameLengthKey
	recurrentTranslations[incorrectPasswordKey] = I18nEasy.i18n incorrectPasswordKey
	recurrentTranslations[invalidEmailKey] = I18nEasy.i18n invalidEmailKey
	recurrentTranslations[internalServerErrorKey] = I18nEasy.i18n internalServerErrorKey
	recurrentTranslations[userNotFoundKey] = I18nEasy.i18n userNotFoundKey

	$errorMessage = $(@find ".error-message")
	errorMessageKey = toKey $errorMessage.text()

	if recurrentTranslations[invalidEmailKey] isnt $errorMessage.text() and errorMessageKey is invalidEmailKey
		$errorMessage.text recurrentTranslations[invalidEmailKey]

	if recurrentTranslations[internalServerErrorKey] isnt $errorMessage.text() and errorMessageKey is internalServerErrorKey
		$errorMessage.text recurrentTranslations[internalServerErrorKey]

	if recurrentTranslations[invalidUserNameLengthKey] isnt $errorMessage.text() and errorMessageKey is invalidUserNameLengthKey
		$errorMessage.text recurrentTranslations[invalidUserNameLengthKey]

	if recurrentTranslations[incorrectPasswordKey] isnt $errorMessage.text() and errorMessageKey is incorrectPasswordKey
		$errorMessage.text recurrentTranslations[incorrectPasswordKey]

	if recurrentTranslations[userNotFoundKey] isnt $errorMessage.text() and errorMessageKey is userNotFoundKey
		$errorMessage.text recurrentTranslations[userNotFoundKey]


	emailSentKey = 'emailsent'
	passwordChangedKey = 'passwordchanged'

	recurrentTranslations[emailSentKey] = I18nEasy.i18n emailSentKey
	recurrentTranslations[passwordChangedKey] = I18nEasy.i18n passwordChangedKey

	$infoMessage = $(@find ".info-message")
	infoMessageKey = toKey $infoMessage.text()

	if recurrentTranslations[emailSentKey] isnt $infoMessage.text() and infoMessageKey is emailSentKey
		$infoMessage.text recurrentTranslations[emailSentKey]

	if recurrentTranslations[passwordChangedKey] isnt $infoMessage.text() and infoMessageKey is passwordChangedKey
		$infoMessage.text recurrentTranslations[passwordChangedKey]


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
			$(@find '#login-name-link')
				.html("<i class='fa fa-user'></i> #{Meteor.user().emails?[0]?.address}")
				.css {
					visibility: 'visible'
					opacity: 1
				}
		else
			$(@find "#login-sign-in-link")
				.html("<i class='fa fa-chevron-down'></i> #{I18nEasy.i18n 'signin'}")
				.css {
					visibility: 'visible'
					opacity: 1
				}

		$loginWrapper = $(@find ".login-wrapper")

		if @find("#login-dropdown-list")
			translateLoginWidget.call(@)
			$loginWrapper.removeClass('closed')
		else
			$loginWrapper.addClass('closed')