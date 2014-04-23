charMap = {}
charMap[char] = index % 10 for char, index in '0123456789abcdefghijklmnopqrstuvwxyz'.split('')

UI.registerHelper(
	'uuidToNumber'
	(uuid)-> (charMap[char] for char in uuid.toLowerCase()).join('')
)


UI.registerHelper(
	'settings'
	-> Settings.findOne userId: Meteor.userId()
)

UI.registerHelper(
	'userEmail'
	-> Meteor.user().emails?[0]?.address
)

UI.registerHelper(
	'configIsReady'
	->
		settings = Settings.findOne(userId: Meteor.userId())
		settings?.company and settings?.companyid and settings?.dailyprice
)

UI.registerHelper(
	'clients'
	-> Clients.find(
		{}
		{sort: name: 1}
	)
)

UI.registerHelper(
	'clientsAreReady'
	-> Clients.findOne name: $exists: yes
)

UI.registerHelper(
	'initials'
	(key)->
		translation = I18nEasy.i18n(key)
		words = translation.split /\s/
		joinChar = '.'
		(word[0] for word in words).join(joinChar) + joinChar
)

UI.registerHelper(
	'shorten'
	(key)->
		translation = I18nEasy.i18n(key)
		translation.slice 0, 2
)

UI.registerHelper(
	'activeRowClass'
	(item)-> 'active-row' if item._id is Router.current().params._id
)