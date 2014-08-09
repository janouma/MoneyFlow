templateName = 'invoiceItems'

dialogDispose = (e, template)->
	do e.preventDefault
	template._cancelDelete = yes
	Meteor.clearTimeout template._deleteToast
	$(template.find '.inline-confirm-buttons').addClass 'hidden'
	$(template.find "##{template._deleteIconId}").addClass 'hidden'
	$(template.find "#item-row-#{template._itemId}").removeClass 'striked-row'


inputDispose = (e, template)->
	do e.preventDefault
	template._cancelMove = yes
	Meteor.clearTimeout template._moveToast
	$(template.find '.floating-text-input').addClass 'hidden'
	$(template.find "##{template._moveIconId}").addClass 'hidden'


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
		inputDispose e, template
		Meteor.clearTimeout template._deleteToast

		$deleteIcon = $(e.target).removeClass 'hidden'
		deleteIconId = $deleteIcon.attr 'id'
		$(template.find "##{template._deleteIconId}").addClass('hidden') if template._deleteIconId and template._deleteIconId isnt deleteIconId
		$(template.find "#item-row-#{template._itemId}").removeClass('striked-row') if template._itemId
		template._deleteIconId = deleteIconId
		template._itemId = $deleteIcon.attr 'data-item-id'
		$itemRow = $(template.find "#item-row-#{template._itemId}")
		$dialog = $deleteIcon.parents('table').siblings('.inline-confirm-buttons')

		offset = $deleteIcon.offset()
		$dialog.offset(
			top: offset.top - $dialog.height()/2 + $deleteIcon.width()/2
			left: offset.left - $dialog.width() - 10
		).removeClass 'hidden'

		$itemRow.addClass 'striked-row'

		template._cancelDelete = no

		template._deleteToast = Meteor.setTimeout(
			->
				template._cancelDelete = yes
				$itemRow.removeClass 'striked-row'
				$dialog.addClass('hidden')
				$deleteIcon.addClass 'hidden'
			5000
		)

	#==========================================
	'transitionend .inline-confirm-buttons, transitionend .floating-text-input': (e)->
		$dialog = $(e.target)
		$dialog.css left: 0 if $dialog.hasClass 'hidden'

	#==========================================
	'click .inline-confirm-buttons .cancel': dialogDispose

	#==========================================
	'click .floating-text-input .cancel': inputDispose

	#==========================================
	'click .inline-confirm-buttons .confirm': (e, template)->
		dialogDispose e, template
		Items.remove _id: template._itemId if template._itemId
		template._itemId = template._deleteIconId = undefined

	#==========================================
	'click .move-item-row': (e, template)->
		dialogDispose e, template
		Meteor.clearTimeout template._moveToast

		$moveIcon = $(e.target).removeClass 'hidden'
		moveIconId = $moveIcon.attr 'id'
		$(template.find "##{template._moveIconId}").addClass('hidden') if template._moveIconId and template._moveIconId isnt moveIconId
		template._moveIconId = moveIconId
		template._itemId = $moveIcon.attr 'data-item-id'
		$itemRow = $(template.find "#item-row-#{template._itemId}")
		$dialog = $moveIcon.parents('table').siblings('.floating-text-input')

		offset = $moveIcon.offset()
		$dialog.offset(
			top: offset.top - $moveIcon.width()/2 #- $dialog.height()/2 + $moveIcon.width()/2
			left: offset.left + $moveIcon.width() + 10
		).removeClass 'hidden'

		template._cancelMove = no

		template._moveToast = Meteor.setTimeout(
			->
				template._cancelMove = yes
				$dialog.addClass('hidden')
				$moveIcon.addClass 'hidden'
			5000
		)

	#==========================================
	###
	'mousedown .move-item-row': (e, template)->
		$row = $(e.target).parents('tr')
		selectedIndex = $row.find('select[name="unit"]').find('option:selected').index()
		$newRow = $row.clone()
		$newRow.removeAttr('id')
		$newRow.find('.delete-item-row').removeClass('delete-item-row')
		$newRow.find('.move-item-row').removeClass('hidden')
		$newRow.find('input,select').attr(disabled: yes, readonly: yes)
		$newRow.find("select[name=unit] option:eq(#{selectedIndex})").attr(selected: yes)

		$dragger = $(template.find '.drag-container')
		$tbody = $dragger.find('tbody').empty()
		$tbody.append $newRow
	###

	#==========================================
	#'mouseup .move-item-row': (e, template)-> $(template.find '.drag-container tbody').empty()
}