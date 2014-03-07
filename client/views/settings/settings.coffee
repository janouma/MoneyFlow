templateName = 'settings'

Template[templateName].helpers {
	defaultTaxerate: -> App.taxerate
	userEmail: -> Meteor.user().emails?[0]?.address
	settings: -> Settings.findOne userId: Meteor.userId()
}

Template[templateName].events {
	'input input, blur input, input textarea, blur textarea': (e, template)->
		$save = $(template.find '#save')

		if template.find ':invalid'
			$save.removeClass('theme-sky').attr disabled:yes
		else
			$save.addClass('theme-sky').removeAttr 'disabled'

	'submit form': (e, template)->
		do e.preventDefault
		return if template.find ':invalid'
		Meteor.clearTimeout template._toast

		hasErrors = no
		hasUpdates = no
		settings = {}

		$(e.target).find('input,textarea').each ->
			return if hasErrors
			value = $(@).val().trim()

			hasUpdates or= value isnt $(@).attr('data-initial-value')

			hasErrors = yes if $(@).attr('required') and not value.length

			if $(@).attr('pattern') and value.length
				pattern = new RegExp $(@).attr('pattern')
				hasErrors and= not pattern.test(value)

			if $(@).attr('type') is 'email' and value.length
				pattern = /^[.-_\w]+@[.-_\w]+$/i
				hasErrors and= not pattern.test(value)

			settings[$(@).attr 'id'] = value if value.length

		unless hasErrors
			settings.taxerate = parseFloat(settings.taxerate.replace /,/, '.') if settings.taxerate
			$saveButton = $(e.target).find('#save').attr(disabled:yes)
			$saveButton.find('.fa').removeClass('fa-check').addClass('fa-cog fa-spin')

			if hasUpdates
				Meteor.call(
					'updateSettings'
					settings
					(error)->
						if not error
							$saveButton.find('.fa').removeClass('fa-check').addClass('fa-cog fa-spin')
							$saveButton.removeClass('theme-sky').addClass('theme-jade')
							template._toast = Meteor.setTimeout(
								->
									$saveButton.find('.fa').removeClass('fa-cog fa-spin').addClass('fa-check')
									$saveButton.removeClass('theme-jade')
								3000
							)
				)
			else
				$saveButton.removeClass('theme-sky').addClass('theme-jade')
				template._toast = Meteor.setTimeout(
					->
						$saveButton.find('.fa').removeClass('fa-cog fa-spin').addClass('fa-check')
						$saveButton.removeClass('theme-jade')
					3000
				)
}