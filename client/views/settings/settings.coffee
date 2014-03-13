templateName = 'settings'

Template[templateName].helpers {
	defaultTaxerate: -> App.taxerate
}

Template[templateName].events {
	'submit form': (e)-> do e.preventDefault

	#==================================
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
					$label = $(template.find "label[for=#{$input.attr 'id'}]")
					$formCell = $label.parent '.form-cell'

					validColorClass = 'color-lightlead'
					validThemeClass = 'theme-lightsilver'
					errorColorClass = 'color-error'
					errorThemeClass = 'theme-error'

					if error
						$formCell.removeClass(validThemeClass).addClass(errorThemeClass)
						$label.removeClass(validColorClass).addClass(errorColorClass)
					else
						$formCell.removeClass(errorThemeClass).addClass(validThemeClass)
						$label.removeClass(errorColorClass).addClass(validColorClass)

			)

}