Template.invoiceRow.helpers {
	formattedInvoiceDate: -> @_id and moment(@invoiceDate).format(App.dateFormat)
	#invoiceClient: -> Clients.findOne _id: @client if @_id and @client
}