Handlebars.registerHelper(
	'settings'
	-> Settings.findOne userId: Meteor.userId()
)

Handlebars.registerHelper(
	'userEmail'
	-> Meteor.user().emails?[0]?.address
)

Handlebars.registerHelper(
	'configIsReady'
	->
		settings = Settings.findOne(userId: Meteor.userId())
		settings?.company and settings?.companyid
)

Handlebars.registerHelper(
	'clients'
	-> Clients.find(
		{}
		{sort: name: 1}
	)
)

Handlebars.registerHelper(
	'clientsAreReady'
	-> Clients.findOne name: $exists: yes
)

Handlebars.registerHelper(
	'initials'
	(key)->
		translation = I18nEasy.i18n(key)
		words = translation.split /\s/
		joinChar = '.'
		(word[0] for word in words).join(joinChar) + joinChar
)