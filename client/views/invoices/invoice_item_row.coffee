templateName = 'invoiceItemRow'

documentPrice = -> @accountingDocument.dailyprice or Settings.findOne(userId: Meteor.userId())?.dailyprice

Template[templateName].helpers {
	selectedUnit: (unit)-> unit is @item.unit
	documentPrice: documentPrice
	sum: ->
		price = @item.itemPrice or documentPrice.call @
		price * @item.amount

	currencyIcon: -> if @accountingDocument.currency is '$' then 'usd' else 'euro'
	unitColor: -> 'color-lightsilver' if @item.unit is 'w'
}

Template[templateName].events {
	'blur input, change select': (e, template)->
		do e.stopPropagation

		$input = $(e.target)

		if Validation.valid $input
			field = $input.attr 'name'
			item = field: field

			value = $input.val().trim()
			if value.length
				item.value = if $input.attr('pattern') then Validation.parse(value) else value

			item._id = template.data.item._id

			Meteor.call(
				'updateItem'
				item
				(error)->
					errorColorClass = 'color-error'
					errorThemeClass = 'theme-error'

					if error
						$input
							.addClass(errorThemeClass)
							.addClass(errorColorClass)
					else
						$input
							.removeClass(errorThemeClass)
							.removeClass(errorColorClass)
			)
}
