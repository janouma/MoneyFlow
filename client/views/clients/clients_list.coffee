templateName = 'clientsList'

showHideDeleteLink = (template, fade = no)->
	$deleteLink = $(template.find '#delete')
	hiddenClass = 'hidden'
	displayClass = 'no-display'

	if template.find 'input[name=client]:checked'
		if fade
			$deleteLink.removeClass(displayClass)
			Meteor.defer -> $deleteLink.removeClass(hiddenClass)
		else
			$deleteLink.removeClass("#{displayClass} #{hiddenClass}")
	else
		$deleteLink.addClass(hiddenClass)


Template[templateName].events {
	'click input[type=checkbox]': (e, template)-> showHideDeleteLink template, yes

	#==========================================
	'transitionend #delete': (e)->
		$deleteLink = $(e.target)

		$deleteLink.toggleClass(
			'no-display'
			$deleteLink.hasClass 'hidden'
		)

	#==========================================
	'click #delete': (e, template)->
		$list = $(template.find 'table')
		$list.find('input[name=client]:checked').parents('tr').addClass 'striked-row'
}


Template[templateName].rendered = -> showHideDeleteLink @