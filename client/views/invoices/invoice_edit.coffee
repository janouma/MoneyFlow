Template.invoiceEdit.events {
	'click .delete-item-row': (e, template)->
		Meteor.clearTimeout template._toast

		$deleteIcon = $(e.target).removeClass 'hidden'
		$dialog = $deleteIcon.parents('table').siblings('.inline-confirm-buttons')

		offset = $deleteIcon.offset()
		$dialog.offset(
			top: offset.top - $dialog.height()/2 + $deleteIcon.width()/2
			left: offset.left - $dialog.width() - 10
		).removeClass 'hidden'

		template._cancel = no

		template._toast = Meteor.setTimeout(
			->
				template._cancel = yes
				$dialog.addClass('hidden')
				$deleteIcon.addClass 'hidden'
			5000
		)

	#==========================================
	'transitionend .inline-confirm-buttons': (e)->
		$dialog = $(e.target)
		$dialog.css left: 0 if $dialog.hasClass 'hidden'
}