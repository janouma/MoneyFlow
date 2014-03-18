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
	'click input[type=checkbox]': (e, template)->
		showHideDeleteLink template, yes

		$list = $(template.find 'table')
		strikedRowClass = 'striked-row'
		$list.find(".#{strikedRowClass}").removeClass strikedRowClass

	#==========================================
	'transitionend #delete': (e)->
		$deleteLink = $(e.target)

		$deleteLink.toggleClass(
			'no-display'
			$deleteLink.hasClass 'hidden'
		)

	#==========================================
	'click #delete': (e, template)->
		Meteor.clearTimeout @_toast
		$list = $(template.find 'table')
		$rows = $list.find('input[name=client]:checked').parents('tr')
		strikedRowClass = 'striked-row'
		$rows.addClass strikedRowClass

		@_toast = Meteor.setTimeout(
			-> $rows.removeClass strikedRowClass
			5000
		)
}


Template[templateName].rendered = -> showHideDeleteLink @