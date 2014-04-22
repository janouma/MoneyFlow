taxerateChecked = ->
	if @_id
		@taxerate in [
			'on'
			'yes'
			'true'
			true
		]
	else
		yes

Template.invoiceSettings.helpers {
	invoicePrice: -> @dailyprice or Settings.findOne(userId: Meteor.userId())?.dailyprice
	taxerateChecked: taxerateChecked
	taxerateCheckedClass: -> 'checked' if taxerateChecked.call(@)
	newDocument: -> not @_id
}