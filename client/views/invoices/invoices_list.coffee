templateName = 'invoicesList'

Template[templateName].helpers {
	invoices: ->
		AccountingDocuments.find(
			{documentType: 'i'}
			{sort: invoiceDate: -1}
		)
}
