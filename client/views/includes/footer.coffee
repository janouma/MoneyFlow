Template.footer.helpers(
    activeLangClass: (language)-> 'active color-black' if language is I18nEasy.getLanguage()
)