documentPrice = -> @accountingDocument.dailyprice or Settings.findOne(userId: Meteor.userId())?.dailyprice

Template.invoiceItemRow.helpers {
	selectedUnit: (unit)-> unit is @item.unit
	documentPrice: documentPrice
	sum: ->
		price = @item.itemPrice or documentPrice.call @
		price * @item.amount

	currencyIcon: -> if @accountingDocument.currency is '$' then 'usd' else 'euro'
}