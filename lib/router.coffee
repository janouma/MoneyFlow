Router.configure(
    layoutTemplate: 'layout'
    
    #CAUTION, this option is not for unmatched route but for null "data" on a matched route
    notFoundTemplate: 'notFound'
)

navigatorLanguage = ->
    results = /(\w{2}).*/gi.exec window.navigator.language
    results.length > 1 and results[1]
    
appLanguage = -> amplify.store('language') or navigatorLanguage() or I18nEasy.getDefault()

setLanguage = ->
    language = @params[0] or @params.language or appLanguage()

    if language and I18nEasy.getLanguage() isnt language
        I18nEasy.setLanguage language
        Session.set 'language', language
        amplify.store 'language', language


Router.before(
    setLanguage
    except: 'notFound'
)

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
        path: '/:language?/clients'
    )
    
    @route(
        'settings'
        path: '/:language?/settings'
    )
    
    @route(
        'notFound'
        path: '*'
        before: -> I18nEasy.setLanguage(appLanguage()) unless Session.get 'language'
    )
