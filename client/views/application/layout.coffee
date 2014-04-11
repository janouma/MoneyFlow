templateName = 'layout'

Template[templateName].events {
	'click input[type=checkbox]': (e)->
		$checkbox = $(e.target)
		$checkboxStyle = $checkbox.parent '.checkbox-style'

		$checkboxStyle.toggleClass(
			'checked'
			$checkbox.val()
		)

	#==========================================
	'click .click-reveal': (e)->
		$('.reveal-toggle [data-delay-shrink]').addClass 'delay-shrink'

		$(e.target)
			.parents('.click-reveal-container')
			.toggleClass('reveal-toggle')

	#==========================================
	'transitionend .click-reveal-container:not(.reveal-toggle) .delay-shrink': (e)->
		$(e.target).removeClass 'delay-shrink'
}


Template[templateName].rendered = -> $('input[type=checkbox]:checked').parent('.checkbox-style').addClass 'checked'