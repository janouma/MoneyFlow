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
			settings = field: $input.attr 'id'
			value = $input.val().trim()

			if value.length
				settings.value = if $input.attr('pattern') then Validation.parse(value) else value

			Meteor.call(
				'updateSettings'
				settings
				(error)->
					$label = $(template.find "label[for=#{$input.attr 'id'}]")
					$formLabel = $label.parent '.form-label'

					errorColorClass = 'color-error'
					errorThemeClass = 'theme-error'

					if error
						$formLabel.addClass(errorThemeClass)
						$label.addClass(errorColorClass)
					else
						$formLabel.removeClass(errorThemeClass)
						$label.removeClass(errorColorClass)

			)

}