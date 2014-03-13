templateName = 'clientEdit'

Template[templateName].helpers {
	client: ->
		if Router.current().params.id
			Clients.findOne _id: Router.current().params.id
}

Template[templateName].events {
	'submit form': (e)-> do e.preventDefault

	###==================================
	'blur input, blur textarea': (e, template)->
		$input = $(e.target)

		if Validation.valid $input
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
	###
}