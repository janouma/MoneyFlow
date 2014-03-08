@Settings = new Meteor.Collection 'settings'

ownsDocument = (userId, doc)-> doc?.userId is userId

@Settings.allow {
	insert: ownsDocument
	update: ownsDocument
}

Meteor.methods {
	updateSettings: (settings)->
		check(
			settings
			company: String
			companyid: String
			email: Match.Optional(Match.Where (email)-> not email.length or (/^[.-_\w]+@[.-_\w]+$/i).test email)
			address: Match.Optional(String)
			taxerate: Match.Optional(Number)
			taxeid: Match.Optional(String)
		)

		settings.userId = Meteor.userId()

		Settings.upsert(
			{userId: settings.userId}
			settings
		)
}