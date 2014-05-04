#Template.invoiceItemRow.selectedUnit = (unit)-> unit is @item.unit

Template.invoiceItemRow.helpers {
	selectedUnit: (unit)-> unit is @item.unit
	documentPrice: -> @accountingDocument.dailyprice or Settings.findOne(userId: Meteor.userId())?.dailyprice
}