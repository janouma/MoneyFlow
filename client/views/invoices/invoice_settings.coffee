Template.invoiceSettings.helpers {
	invoicePrice: -> @dailyprice or Settings.findOne(userId: Meteor.userId())?.dailyprice
}