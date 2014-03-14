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

			client.value = Validation.parseFloat client.value
			client._id = Router.current().params._id if Router.current().params._id

			$label = $(template.find "label[for=#{$input.attr 'id'}]")
			$formCell = $label.parent '.form-cell'

			Meteor.call(
				'updateClient'
				client
				(error, newId)->
					validColorClass = 'color-lightlead'
					validThemeClass = 'theme-lightsilver'
					errorColorClass = 'color-error'
					errorThemeClass = 'theme-error'

					if error
						$formCell.removeClass(validThemeClass).addClass(errorThemeClass)
						$label.removeClass(validColorClass).addClass(errorColorClass)
					else
						if client._id
							$formCell.removeClass(errorThemeClass).addClass(validThemeClass)
							$label.removeClass(errorColorClass).addClass(validColorClass)
						else
							Router.go 'clients', _id: newId
			)
}