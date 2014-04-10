Template.footer.helpers(
	activeLanguageClass: (language)-> 'active' if language is I18nEasy.getLanguage()
	activeFlagClass: (language)-> if language is I18nEasy.getLanguage() then 'fa-flag' else 'fa-flag-o'
	languages: -> do I18nEasy.getLanguages
	writeIsAllowed: -> I18nEasy.writeIsAllowed()
	year: -> new Date().getFullYear()
)