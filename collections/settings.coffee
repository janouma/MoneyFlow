@Settings = new Meteor.Collection 'settings'

ownsDocument = (userId, doc)-> doc?.userId is userId

@Settings.allow {
	insert: ownsDocument
	update: ownsDocument
}

Meteor.methods {
	updateSettings: (settings)->
		throw new Meteor.Error(403, 'Authetication required') unless Meteor.user()

		check(
			settings

			field: Match.Where (field)->
				check field, String
				field in ["company", "companyid", "email", "address", "taxerate"]

			value: Match.Optional(Match.OneOf String, Number)
		)

		updateOperator = if settings.value?.toString().length then "$set" else "$unset"

		modifier = {}
		modifier[updateOperator] = {}
		modifier[updateOperator][settings.field] = settings.value


		Settings.upsert(
			{userId: Meteor.userId()}
			modifier
		)
}