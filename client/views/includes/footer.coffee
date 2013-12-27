Template.footer.helpers(
    activeLangClass: (lang)-> 'active color-black' if lang is Session.get('lang')
    pathToLang: (lang)->
        currentRoute = Router.current().route
        if currentRoute.name is 'home' then "/#{lang}" else currentRoute.path(lang: lang)
)