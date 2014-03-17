Template.clientsList.events {
	'click input[type=checkbox]': (e, template)->
		$deleteLink = $(template.find '#delete')
		hiddenClass = 'hidden'
		displayClass = 'no-display'

		if template.find 'input[name=client]:checked'
			$deleteLink.removeClass(displayClass)
			Meteor.defer -> $deleteLink.removeClass(hiddenClass)
		else
			$deleteLink.addClass(hiddenClass)

	'transitionend #delete': (e)->
		$deleteLink = $(e.target)

		$deleteLink.toggleClass(
			'no-display'
			$deleteLink.hasClass 'hidden'
		)
}