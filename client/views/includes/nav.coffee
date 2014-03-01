templateName = 'nav'

Template[templateName].helpers(
    activeRouteClass: (routeNames...)->
        activeRoutePattern = new RegExp "^(\w{2}\/)?#{Router.current().route.name}\/?"
        # routeNames[0...] gets rid of the hash added by handlebars
        return 'active' for route in routeNames[0...] when activeRoutePattern.test route
)

Template[templateName].rendered = ->
	signInKey = 'signin'
	createAccountKey = 'createaccount'

	translations = {}
	translations[signInKey] = I18nEasy.i18n signInKey
	translations[createAccountKey] = I18nEasy.i18n createAccountKey

	$(@find "#login-sign-in-link").text "▾ #{translations[signInKey]}"
	$(@find ".login-close-text").text I18nEasy.i18n('close')
	$(@find ".sign-in-text-google").text "#{I18nEasy.i18n 'signin'} #{I18nEasy.i18n 'with'} google"
	$(@find ".sign-in-text-twitter").text "#{I18nEasy.i18n 'signin'} #{I18nEasy.i18n 'with'} twitter"
	$(@find ".or-text").text I18nEasy.i18n('or')
	$(@find "#login-email").attr(placeholder: I18nEasy.i18n('email'))
	$(@find "#login-password").attr(placeholder: I18nEasy.i18n('password'))
	$(@find "#signup-link").text translations[createAccountKey]
	$(@find "#forgot-password-link").text I18nEasy.i18n('forgotPassword')

	$actionButton = $(@find "#login-buttons-password")
	actionButtonKey = $actionButton.text().replace(/\W*/g, '').toLowerCase()

	if translations[signInKey] isnt $actionButton.text() and actionButtonKey is signInKey
		$actionButton.text translations[signInKey]
		$actionButton.removeClass('fa-user')
			.addClass('fa-sign-in')

	if translations[createAccountKey] isnt $actionButton.text() and actionButtonKey is createAccountKey
		$actionButton.text translations[createAccountKey]
		$actionButton.removeClass('fa-sign-in')
			.addClass('fa-user')