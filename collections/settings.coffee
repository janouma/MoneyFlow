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

			email: Match.Where (email)->
				check email, Match.Optional(String)
				email.length and (/^[.-_\w]+@[.-_\w]+$/i).test email

			address: Match.Optional(String)
			taxerate: Match.Optional(Number)
			taxeid: Match.Optional(String)
		)

		Settings.upsert(
			{userId: Meteor.userId()}
			$set: settings
		)
}