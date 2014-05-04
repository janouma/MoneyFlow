templateName = 'invoiceNewItem'

fieldsMapping =
	item: 'item'
	amount: 'amount'
	unit: 'unit'
	group: 'group'
	itemPrice: 'item-price'

Template[templateName].helpers {
	currencyIcon: -> if @currency is '$' then 'usd' else 'euro'
}

Template[templateName].events {

	'blur input, change select': (e, template)->
		do e.stopPropagation

		validated = yes

		item =
			userId: Meteor.userId()
			documentId: template.data._id

		inputs = []

		for field, inputId of fieldsMapping
			inputs.push($input = $("##{inputId}"))
			value = $input.val().trim()

			if value.length
				item[field] = if $input.attr('pattern') then Validation.parse(value) else value

			validated and= Validation.valid $input, noInitialValue: yes

		validated and= item.unit in ['d','h'] or item.itemPrice

		if validated
			Items.insert item
			$input.val('') for $input in inputs when $input.prop('tagName').toLowerCase() isnt 'select'
			$('#unit').find('option:selected').removeAttr('selected')
}