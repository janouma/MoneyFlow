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

		$container = $(e.target).parents('.click-reveal-container')
		$container.toggleClass('reveal-toggle')
		$container.toggleClass('unfolded') if $container.hasClass 'folder'


	#==========================================
	'transitionend .click-reveal-container:not(.reveal-toggle) .delay-shrink': (e)->
		$(e.target).removeClass 'delay-shrink'
}


Template[templateName].rendered = -> $('input[type=checkbox]:checked').parent('.checkbox-style').addClass 'checked'