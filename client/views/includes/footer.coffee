Template.footer.helpers(
    activeLangClass: (language)-> 'active color-black' if language is I18nEasy.getLanguage()

    pathToLanguage: (language)->
        try
            Router.current().route.path(language: language)
        catch error
            Meteor._debug """
            Warning: #{error.message}
             |_route: #{Router.current().route.name}
             |_path: #{Router.current().path}
             |_template: #{Router.current().template}
             |_language: #{language}
            """
            "/#{language}"
)