Handlebars.registerHelper(
	'settings'
	-> Settings.findOne userId: Meteor.userId()
)