Template.invoiceRow.helpers {
	formattedInvoiceDate: -> @_id and moment(@invoiceDate).format(App.dateFormat)
}