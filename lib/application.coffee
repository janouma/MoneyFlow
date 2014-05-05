@App =
	taxerate: 20
	dateFormat: 'DD/MM/YYYY'

	invoiceDefaults: ->
		taxerate: yes
		documentType: 'i'
		invoiceDate: new Date()
		currency: '€'