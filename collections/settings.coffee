@Settings = new Meteor.Collection 'settings'

@Settings.allow {
	insert: ownsDocument
	update: ownsDocument
}

Meteor.methods {
	updateSettings: (settings)->
		throw new Meteor.Error(403, 'Authetication required') unless Meteor.user()

		check(
			settings
			Match.OneOf(
				{
					field: Match.Where (field)->
						check field, String
						field in ["email", "address", "taxerate"]

					value: Match.Optional(Match.OneOf String, Number)
				}
				{
					field: Match.Where (field)->
						check field, String
						field in ["company", "companyid"]

					value: Match.OneOf String, Number
				}
			)
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