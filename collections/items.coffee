@Items = new Meteor.Collection 'items'

@Items.allow {
	insert: ownsDocument
	update: ownsDocument
	remove: ownsDocument
}

validate = (item)->
	unitValidator = Match.Where (unit)-> unit in ['d','h','w']

	expectedFields =
		item: String
		amount: Number
		unit: unitValidator
		itemPrice: Match.Optional Number

	check(
		item
		{
			_id: String

			field: Match.Where (field)->
				check field, String
				expectedFields.hasOwnProperty field

			value: expectedFields[item.field]
		}
	)

Meteor.methods {
	updateItem: (item)->
		throw new Meteor.Error(403, 'Authentication required') unless Meteor.user()
		validate item

		_id = item._id
		value = item.value
		field = item.field

		updateOperator = if value?.toString().length then "$set" else "$unset"
		modifier = {}
		modifier[updateOperator] = {}
		modifier[updateOperator][field] = value

		Items.update(
			{_id: _id}
			modifier
		)
}