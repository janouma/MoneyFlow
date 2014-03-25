Template.invoiceEdit.events {
	'submit form': (e)-> do e.preventDefault

	#==========================================
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

	#==========================================
	'click .inline-confirm-buttons .cancel': (e, template)->
		do e.preventDefault
		template._cancel = yes
		Meteor.clearTimeout template._toast
		$(template.find '.inline-confirm-buttons').addClass 'hidden'
		$(template.find '.delete-item-row').addClass 'hidden'
}