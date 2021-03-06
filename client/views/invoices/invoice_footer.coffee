documentPrice = -> @invoice?.dailyprice or Settings.findOne(userId: Meteor.userId())?.dailyprice


taxeRate = ->
	settings = Settings.findOne(userId: Meteor.userId())
	(settings?.taxerate or App.taxerate)/100


taxeFreeSum = ->
	sum = 0

	@items?.rewind()

	@items?.forEach (item)=>
		price = item.itemPrice or documentPrice.call @
		itemSum = price * item.amount
		sum += Math.ceil(Converter.toDays itemSum, item.unit)

	sum


taxes = -> if @invoice?.taxerate then taxeRate() * taxeFreeSum.call(@) else 0


Template.invoiceFooter.helpers {
	currencyIcon: -> if @invoice?.currency is '$' then 'usd' else 'euro'

	taxeFreeSum: -> Formatter.toFixed (taxeFreeSum.call @), 2

	taxes: -> Formatter.toFixed (taxes.call @), 2

	sumWithTaxes: ->
		freeOfTaxes = taxeFreeSum.call @
		Formatter.toFixed (freeOfTaxes + taxes.call @), 2
}