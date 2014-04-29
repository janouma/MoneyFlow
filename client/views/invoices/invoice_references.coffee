Template.invoiceReferences.helpers {
	formatedInvoiceDate: -> moment(if @_id then @invoiceDate else new Date()).format App.dateFormat
	termDate: ->
		if @_id
			term = @term or 0
			invoiceDate = @invoiceDate or new Date()
		else
			term = 0
			invoiceDate = new Date()

		moment(invoiceDate).add('days', term).format App.dateFormat
}
