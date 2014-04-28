templateName = 'clientEdit'

Template[templateName].helpers {
	client: ->
		if Router.current().params._id
			Clients.findOne _id: Router.current().params._id
}

Template[templateName].events {
	'submit form': (e)-> do e.preventDefault

	#==================================
	'blur input, blur textarea': (e, template)->
		$input = $(e.target)

		if Validation.valid $input
			client =
				field: $input.attr 'id'
				value: $input.val().trim()

			client._id = Router.current().params._id if Router.current().params._id

			$label = $(template.find "label[for=#{$input.attr 'id'}]")
			$formLabel = $label.parent '.form-label'

			Meteor.call(
				'updateClient'
				client
				(error, newId)->
					errorColorClass = 'color-error'
					errorThemeClass = 'theme-error'

					if error
						$formLabel.addClass(errorThemeClass)
						$label.addClass(errorColorClass)
					else
						if client._id
							$formLabel.removeClass(errorThemeClass)
							$label.removeClass(errorColorClass)
						else
							Router.go 'clients', _id: newId
			)
}