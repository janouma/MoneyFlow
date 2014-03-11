Handlebars.registerHelper(
	'settings'
	-> Settings.findOne userId: Meteor.userId()
)

Handlebars.registerHelper(
	'userEmail'
	-> Meteor.user().emails?[0]?.address
)