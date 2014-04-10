templateName = 'layout'

Template[templateName].events {
	'click input[type=checkbox]': (e)->
		$checkbox = $(e.target)
		$checkboxStyle = $checkbox.parent '.checkbox-style'

		$checkboxStyle.toggleClass(
			'checked'
			$checkbox.val()
		)
}


Template[templateName].rendered = -> $('input[type=checkbox]:checked').parent('.checkbox-style').addClass 'checked'