templateName = 'settings'

Template[templateName].helpers {
	defaultTaxerate: -> App.taxerate
	userEmail: -> Meteor.user().emails?[0]?.address
	settings: -> Settings.findOne userId: Meteor.userId()
}

Template[templateName].events {
	'input input, blur input': (e, template)->
		$save = $(template.find '#save')

		if template.find ':invalid'
			$save.removeClass('theme-sky').attr disabled:yes
		else
			$save.addClass('theme-sky').removeAttr 'disabled'

	'submit form': (e, template)->
		do e.preventDefault
		return if template.find ':invalid'

		hasErrors = no
		settings = {}

		$(e.target).find('input,textarea').each ->
			return if hasErrors

			value = $(@).val().trim()

			hasErrors = yes if $(@).attr('required') and not value.length

			if $(@).attr('pattern')
				pattern = new RegExp $(@).attr('pattern')
				hasErrors and= not pattern.test(value)

			if $(@).attr('type') is 'email'
				pattern = /^[.-_\w]+@[.-_\w]+$/i
				hasErrors and= not pattern.test(value)

			if $(@).attr('type') is 'number'
				pattern = /^\d+(,|\.)?\d+$/
				hasErrors and= not pattern.test(value)

			settings[$(@).attr 'id'] = value if value.length

		Meteor.call('updateSettings', settings) unless hasErrors
}