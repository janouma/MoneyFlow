invoices = -> AccountingDocuments.find(documentType: 'i')

Template.invoices.helpers {
	invoiceEdition: ->
		truth = Router.current().params._id
		truth and= AccountingDocuments.findOne {_id: Router.current().params._id}
		truth or= Router.current().params.new
		truth or= not invoices().count()

	invoices: -> invoices()

	listOptions: ->
		template: Template.invoicesList
		item: 'invoice'
		collection: AccountingDocuments
}