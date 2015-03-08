subsManager = new SubsManager()

Router.configure(
    layoutTemplate: 'layout'

#CAUTION, this option is not for unmatched route but for null "data" on a matched route
#notFoundTemplate: 'notFound'

    waitOn: ->
        subscriptions = [
            subsManager.subscribe 'settings', Meteor.userId()
            subsManager.subscribe 'clients', Meteor.userId()
        ]

        subscriptions.push I18nEasy.subscribe()... unless Meteor.isServer
        subscriptions

    fastRender: true
)

Router.plugin 'loading', loadingTemplate: 'Loading'
Router.plugin 'dataNotFound', dataNotFoundTemplate: 'NotFound'

navigatorLanguage = ->
    results = /(\w{2}).*/gi.exec window.navigator.language
    results.length > 1 and results[1]

appLanguage = ->
    amplify.store('language') or navigatorLanguage()

setLanguage = ->
    return unless Meteor.isClient

    language = @params[0] or @params.language or appLanguage()

    if language and I18nEasy.getLanguage() isnt language
        I18nEasy.setLanguage language
        amplify.store 'language', language

    do @next


Router.onBeforeAction(
    setLanguage
    except: 'notFound'
)

Router.onBeforeAction(
    ->
        Router.go '/' unless Meteor.user()
        do @next

    except: ['notFound', 'home', 'i18n_easy_admin']
)

Router.onBeforeAction(
    ->
        settings = Settings.findOne(userId: Meteor.userId())
        Router.go '/' unless settings?.company and settings?.companyid and settings?.dailyprice
        do @next

    except: ['notFound', 'home', 'settings']
)

Router.onBeforeAction(
    ->
        Router.go '/' unless Clients.findOne name: $exists: yes
        do @next

    except: ['notFound', 'home', 'settings', 'clients']
)

Router.route(
    /^\/(\w{2})?$/
    name: 'home'
)

Router.route(
    '/:language?/invoices/:_id?'
    name: 'invoices'
    waitOn: -> [
        subsManager.subscribe('invoices', Meteor.userId())
        subsManager.subscribe('items', Meteor.userId())
    ]
)

Router.route(
    '/:language?/orders'
    name: 'orders'
)

Router.route(
    '/:language?/clients/:_id?'
    name: 'clients'
)

Router.route(
    '/:language?/settings'
    name: 'settings'
)

Router.route(
    '/(.*)'
    name: 'notFound'
    onBeforeAction: ->
        fallback = appLanguage()
        unless I18nEasy.getLanguage() is fallback
            I18nEasy.setLanguage fallback
        do @next
)
