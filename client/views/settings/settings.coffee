templateName = 'settings'

Template[templateName].helpers {
	taxerate: -> App.taxerate
}

Template[templateName].events {
	'input input': (e, template)->
		$save = $(template.find '#save')

		if template.find ':invalid'
			$save.removeClass('theme-sky').addClass('disabled').attr disabled:yes
		else
			$save.addClass('theme-sky').removeClass('disabled').removeAttr 'disabled'

	'submit form': (e, template)->
		do e.preventDefault
}