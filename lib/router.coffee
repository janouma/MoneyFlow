subsManager = new SubsManager()

Router.configure(
	layoutTemplate: 'layout'
	loadingTemplate: 'loading'

	#CAUTION, this option is not for unmatched route but for null "data" on a matched route
	notFoundTemplate: 'notFound'

	waitOn: ->
		subscriptions = [
			subsManager.subscribe 'settings', Meteor.userId()
			subsManager.subscribe 'clients', Meteor.userId()
		]

		subscriptions.push I18nEasy.subscribe()... unless Meteor.isServer
		subscriptions

	fastRender: true
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


Router.onBeforeAction(
	setLanguage
	except: 'notFound'
)

Router.onBeforeAction(
	-> Router.go '/' unless Meteor.user()
	except: ['notFound', 'home', 'i18n_easy_admin']
)

Router.onBeforeAction('loading')

Router.onBeforeAction(
	->
		settings = Settings.findOne(userId: Meteor.userId())
		Router.go '/' unless settings?.company and settings?.companyid and settings?.dailyprice

	except: ['notFound', 'home', 'settings']
)

Router.onBeforeAction(
	-> Router.go '/' unless Clients.findOne name: $exists: yes
	except: ['notFound', 'home', 'settings', 'clients']
)




Router.map ->
	@route(
		'home'
		path: /^\/(\w{2})?$/
	)

	@route(
		'invoices'
		path: '/:language?/invoices/:_id?'
		waitOn: -> [
			subsManager.subscribe('invoices', Meteor.userId())
			subsManager.subscribe('items', Meteor.userId())
		]
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
