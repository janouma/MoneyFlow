formattedInvoiceDate = -> moment(@_id and @invoiceDate or new Date()).format App.dateFormat

Template.invoiceReferences.helpers {
	formatedInvoiceDate: -> formattedInvoiceDate.call @
	termDate: -> formattedInvoiceDate.call @
}
