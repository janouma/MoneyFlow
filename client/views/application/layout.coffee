templateName = 'layout'

Template[templateName].events {
	'click input[type=checkbox]': (e)->
		$checkbox = $(e.target)
		$checkboxStyle = $checkbox.parent '.checkbox-style'

		$checkboxStyle.toggleClass(
			'checked'
			$checkbox.val()
		)

	'click .click-reveal': (e)->
		$(e.target)
			.parents('.click-reveal-container')
			.toggleClass('reveal-toggle')
}


Template[templateName].rendered = -> $('input[type=checkbox]:checked').parent('.checkbox-style').addClass 'checked'