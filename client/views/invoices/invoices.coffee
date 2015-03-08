invoices = -> AccountingDocuments.find(documentType: 'i')

templateName = 'invoices'

Template[templateName].helpers {
	invoiceEdition: ->
		truth = Router.current().params._id
		truth and= AccountingDocuments.findOne {_id: Router.current().params._id}
		truth or= Router.current().params.query.new
		truth or= not invoices().count()

	invoices: -> invoices()

	listOptions: ->
		template: Template.invoicesList
		item: 'invoice'
		collection: AccountingDocuments
		cascadeDelete: (invoiceId)-> Meteor.call 'removeChildItems', invoiceId
}

Template[templateName].events {
	#============================================
	'click tr.clickable': (e, template)->
		$('.inline-confirm-buttons, .floating-text-input, .move-item-row, .delete-item-row').addClass 'hidden'
		$(template.find ".striked-row").removeClass 'striked-row'
}
