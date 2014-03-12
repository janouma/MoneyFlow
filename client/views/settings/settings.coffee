templateName = 'settings'

valid = ($input)->
	return false unless $input
	value = $input.val().trim()
	validated = value isnt $input.attr('data-initial-value')
	validated and= not $input.attr('required') or value.length
	validated and= not value.length or not $input.attr('pattern') or (new RegExp $input.attr('pattern')).test(value)
	validated and= not value.length or $input.attr('type') isnt 'email' or (/^[.-_\w]+@[.-_\w]+$/i).test(value)


Template[templateName].helpers {
	defaultTaxerate: -> App.taxerate
}

Template[templateName].events {
	'submit form': (e)-> do e.preventDefault

	#==================================
	'blur input, blur textarea': (e, template)->
		$input = $(e.target)

		if valid $input
			settings =
				field: $input.attr 'id'
				value: $input.val().trim()

			settings.value = parseFloat(settings.value.replace /,/g, '.') if settings.value.match /^\d+(,|\.)?\d+$/

			Meteor.call(
				'updateSettings'
				settings
				(error)->
					#DEBUG
					Meteor._debug error
					##
			)

}