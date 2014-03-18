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
		Meteor.clearTimeout template._toast

		showHideDeleteLink template, yes

		$list = $(template.find 'table')
		strikedRowClass = 'striked-row'
		$(template.find '.confirm-buttons').addClass 'hidden'
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
		Meteor.clearTimeout template._toast

		$list = $(template.find 'table')
		$rows = $list.find('input[name=client]:checked').parents('tr')
		strikedRowClass = 'striked-row'
		$rows.addClass strikedRowClass

		$dialog = $(template.find '.confirm-buttons')
		$deleteLink = $(e.target)
		offset = $deleteLink.offset()

		$dialog.offset(
			top: offset.top - $dialog.height() + 4
			left: offset.left + $deleteLink.width()/2 + 9 - $dialog.width()/2
		).removeClass 'hidden'

		template._cancel = no

		template._toast = Meteor.setTimeout(
			->
				template._cancel = yes
				$dialog.addClass 'hidden'
				$rows.removeClass strikedRowClass
			5000
		)
}


Template[templateName].rendered = -> showHideDeleteLink @