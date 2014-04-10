Router.configure(
	layoutTemplate: 'layout'
	loadingTemplate: 'loading'

	#CAUTION, this option is not for unmatched route but for null "data" on a matched route
	notFoundTemplate: 'notFound'

	waitOn: -> [
		I18nEasy.subscribe()...,
		Meteor.subscribe 'settings', Meteor.userId()
		Meteor.subscribe 'clients', Meteor.userId()
	]
)

navigatorLanguage = ->
	results = /(\w{2}).*/gi.exec window.navigator.language
	results.length > 1 and results[1]

appLanguage = ->
	amplify.store('language') or navigatorLanguage()

setLanguage = ->
	language = @params[0] or @params.language or appLanguage()

	if language and I18nEasy.getLanguage() isnt language
		I18nEasy.setLanguage language
		amplify.store 'language', language


unless Meteor.isServer
	Router.onBeforeAction(
		setLanguage
		except: 'notFound'
	)

	Router.onBeforeAction(
		-> Router.go '/' unless Meteor.user()
		except: ['notFound', 'home', 'i18n_easy_admin']
	)

	Router.onBeforeAction('loading')

Router.map ->
	@route(
		'home'
		path: /^\/(\w{2})?$/
	)

	@route(
		'invoices'
		path: '/:language?/invoices'
	)

	@route(
		'orders'
		path: '/:language?/orders'
	)

	@route(
		'clients'
		path: '/:language?/clients/:_id?'
	)

	@route(
		'settings'
		path: '/:language?/settings'
	)

	@route(
		'notFound'
		path: '*'
		onBeforeAction: ->
			fallback = appLanguage()
			unless I18nEasy.getLanguage() is fallback
				I18nEasy.setLanguage fallback
	)
