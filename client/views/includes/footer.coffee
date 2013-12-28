Template.footer.helpers(
    activeLangClass: (lang)->
        #TODO Use I18n.languages instead of ['en', 'fr'] constant
        unless Session.get('lang') not in ['en', 'fr']
            'active color-black' if lang is Session.get('lang')
        else
            #TODO Use I18n.defaultLang instead of 'fr' constant
            'active color-black' if lang is 'fr'

    pathToLang: (lang)->
        try
            Router.current().route.path(lang: lang)
        catch error
            Meteor._debug """
            Error: #{error.message}
             |_route: #{Router.current().route.name}
             |_lang: #{lang}
            """
            "/#{lang}"
)