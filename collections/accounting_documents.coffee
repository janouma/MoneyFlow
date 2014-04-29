@AccountingDocuments = new Meteor.Collection 'accounting_documents'

@AccountingDocuments.allow {
	insert: ownsDocument
	update: ownsDocument
	remove: ownsDocument
}

validate = (accountingDocument)->
	docTypeValidator = Match.Where (docType)-> docType in ['i','o']
	currencyValidator = Match.Where (cur)-> cur in ['€','$']

	expectedFields =
		documentType: docTypeValidator
		currency: currencyValidator
		invoiceDate: Date
		client: String
		dailyprice: Match.Optional Number
		taxerate: Match.Optional Boolean
		term: Match.Optional Number

	check(
		accountingDocument
		{
			_id: Match.Optional(String)

			defaults: Match.Optional {
				taxerate: Match.Optional Boolean
				documentType: Match.Optional docTypeValidator
				invoiceDate: Match.Optional Date
				currency: Match.Optional currencyValidator
			}

			field: Match.Where (field)->
				check field, String
				expectedFields.hasOwnProperty field

			value: expectedFields[accountingDocument.field]
		}
	)


Meteor.methods {
	updateAccountingDocument: (accountingDocument)->
		throw new Meteor.Error(403, 'Authetication required') unless Meteor.user()
		validate accountingDocument

		_id = accountingDocument._id
		value = accountingDocument.value
		field = accountingDocument.field

		if _id
			updateOperator = if value?.toString().length then "$set" else "$unset"
			modifier = {}
			modifier[updateOperator] = {}
			modifier[updateOperator][field] = value

			AccountingDocuments.update(
				{_id: _id}
				modifier
			)
		else
			document = userId: Meteor.userId()
			document[defaultProperty] = defaultValue for defaultProperty, defaultValue of accountingDocument.defaults
			document[field] = value if value?.toString().length
			AccountingDocuments.insert document
}