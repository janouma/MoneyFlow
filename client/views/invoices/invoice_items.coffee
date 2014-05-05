dialogDispose = (e, template)->
	do e.preventDefault
	template._cancel = yes
	Meteor.clearTimeout template._toast
	$(template.find '.inline-confirm-buttons').addClass 'hidden'
	$(template.find "##{template._deleteIconId}").addClass 'hidden'


Template.invoiceItems.events {
	'click .delete-item-row': (e, template)->
		Meteor.clearTimeout template._toast

		$deleteIcon = $(e.target).removeClass 'hidden'
		$(template.find "##{template._deleteIconId}").addClass('hidden') if template._deleteIconId
		template._deleteIconId = $deleteIcon.attr 'id'
		template._itemId = $deleteIcon.attr 'data-item-id'
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
	'click .inline-confirm-buttons .cancel': dialogDispose

	#==========================================
	'click .inline-confirm-buttons .confirm': (e, template)->
		dialogDispose e, template
		Items.remove _id: template._itemId

}