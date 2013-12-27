Router.configure(
    layoutTemplate: 'layout'
)

setLang = ->
    lang = @params[0] or @params.lang or amplify.store('lang')

    unless lang
        results = /(\w{2}).*/gi.exec window.navigator.language
        lang = results.length > 1 and results[1]
        
    if lang and Session.get('lang') isnt lang
        Session.set('lang', lang)
        amplify.store('lang', lang)


Router.before setLang


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