templateName = 'invoiceItems'

dialogDispose = (e, template)->
	do e.preventDefault
	template._cancel = yes
	Meteor.clearTimeout template._toast
	$(template.find '.inline-confirm-buttons').addClass 'hidden'
	$(template.find "##{template._deleteIconId}").addClass 'hidden'
	$(template.find "#item-row-#{template._itemId}").removeClass 'striked-row'


itemsAvailable = -> @invoice and Items.findOne(documentId: @invoice._id)


Template[templateName].helpers {
	itemsAvailable: itemsAvailable

	itemsByGroup: ->
		groups = undefined
		indexedGroups = {}

		if itemsAvailable.call @
			@items.forEach (item)->
				groupName = item.group
				groups ?= []
				groups.push(group = indexedGroups[groupName] = {group: groupName, items: []}) if not group = indexedGroups[groupName]
				group.items.push item

			@items.rewind()

		groups
}

Template[templateName].events {
	'click .delete-item-row': (e, template)->
		Meteor.clearTimeout template._toast

		$deleteIcon = $(e.target).removeClass 'hidden'
		$(template.find "##{template._deleteIconId}").addClass('hidden') if template._deleteIconId
		$(template.find "#item-row-#{template._itemId}").removeClass('striked-row') if template._itemId
		template._deleteIconId = $deleteIcon.attr 'id'
		template._itemId = $deleteIcon.attr 'data-item-id'
		$itemRow = $(template.find "#item-row-#{template._itemId}")
		$dialog = $deleteIcon.parents('table').siblings('.inline-confirm-buttons')

		offset = $deleteIcon.offset()
		$dialog.offset(
			top: offset.top - $dialog.height()/2 + $deleteIcon.width()/2
			left: offset.left - $dialog.width() - 10
		).removeClass 'hidden'

		$itemRow.addClass 'striked-row'

		template._cancel = no

		template._toast = Meteor.setTimeout(
			->
				template._cancel = yes
				$itemRow.removeClass 'striked-row'
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
		Items.remove _id: template._itemId if template._itemId
		template._itemId = template._deleteIconId = undefined

}