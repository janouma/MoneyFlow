Router.configure(
    layoutTemplate: 'layout'
    
    #CAUTION, this option is not for unmatched route but for null "data" on a matched route
    notFoundTemplate: 'notFound'
)

navigatorLang = ->
    results = /(\w{2}).*/gi.exec window.navigator.language
    results.length > 1 and results[1]
    
appLang = -> amplify.store('lang') or navigatorLang() or 'fr' #TODO Use I18n.defaultLang instead of 'fr' constant

setLang = ->
    lang = @params[0] or @params.lang or appLang()

    if lang and Session.get('lang') isnt lang
        Session.set('lang', lang)
        amplify.store('lang', lang)


Router.before(
    setLang
    except: 'notFound'
)

Router.map ->

    @route(
        'home'
        path: /^\/(\w{2})?$/
    )
    
    @route(
        'invoices'
        path: '/:lang?/invoices'
    )
    
    @route(
        'orders'
        path: '/:lang?/orders'
    )
    
    @route(
        'clients'
        path: '/:lang?/clients'
    )
    
    @route(
        'settings'
        path: '/:lang?/settings'
    )
    
    @route(
        'notFound'
        path: '*'
        before: ->
            unless Session.get 'lang'
                Session.set(
                    'lang'
                    appLang()
                )
    )