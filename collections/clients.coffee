@Clients = new Meteor.Collection 'clients'

@Clients.allow {
	insert: ownsDocument
	update: ownsDocument
	remove: ownsDocument
}

Meteor.methods {
	updateClient: (client)->
		throw new Meteor.Error(403, 'Authetication required') unless Meteor.user()

		check(
			client
			Match.OneOf(
				{
					_id: Match.Optional(String)
					field: Match.Where (field)->
						check field, String
						field in ["email", "address"]

					value: Match.Optional(Match.OneOf String, Number)
				}
				{
					_id: Match.Optional(String)
					field: Match.Where (field)->
						check field, String
						field is "name"

					value: String
				}
			)
		)

		if client._id
			updateOperator = if client.value?.toString().length then "$set" else "$unset"
			modifier = {}
			modifier[updateOperator] = {}
			modifier[updateOperator][client.field] = client.value

			Clients.update(
				{_id: client._id}
				modifier
			)
		else
			if client.value?.toString().length
				document = userId: Meteor.userId()
				document[client.field] = client.value
				Clients.insert document
}