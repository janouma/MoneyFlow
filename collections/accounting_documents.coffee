@AccountingDocuments = new Meteor.Collection 'accounting_documents'

@AccountingDocuments.allow {
	insert: ownsDocument
	update: ownsDocument
	remove: ownsDocument
}

Meteor.methods {
	updateAccountingDocument: (accountingDocument)->
		throw new Meteor.Error(403, 'Authetication required') unless Meteor.user()

		docTypes = ['i','o']

		check(
			accountingDocument
			Match.OneOf(
				{
					_id: Match.Optional(String)
					field: Match.Where (field)->
						check field, String
						field in ["dailyprice", "taxerate"]

					value: Match.Optional(Match.OneOf String, Number, Boolean)

					documentType: Match.Optional(
						Match.Where (docType)-> docType in docTypes
					)
				}
				{
					_id: Match.Optional(String)
					field: Match.Where (field)->
						check field, String
						field in ["documentType", "currency"]

					value: Match.OneOf String, Number

					documentType: Match.Optional(
						Match.Where (docType)-> docType in docTypes
					)
				}
			)
		)

		if accountingDocument._id
			value = accountingDocument.value
			field = accountingDocument.field
			updateOperator = if value?.toString().length then "$set" else "$unset"
			modifier = {}
			modifier[updateOperator] = {}
			modifier[updateOperator][field] = value

			AccountingDocuments.update(
				{_id: accountingDocument._id}
				modifier
			)
		else
			if accountingDocument.value?.toString().length
				document = userId: Meteor.userId()
				document[accountingDocument.field] = accountingDocument.value
				docType = accountingDocument.documentType
				document.documentType = docType if docType
				AccountingDocuments.insert document
}