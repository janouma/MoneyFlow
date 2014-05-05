templateName = 'invoiceNewItem'

fieldsMapping =
	item: 'item'
	amount: 'amount'
	unit: 'unit'
	group: 'group'
	itemPrice: 'item-price'


validate = (template)->
	validated = yes

	item =
		userId: Meteor.userId()
		documentId: template.data._id

	inputs = []

	for field, inputId of fieldsMapping
		inputs.push($input = $(template.find "##{inputId}"))
		value = $input.val().trim()

		if value.length
			item[field] = if $input.attr('pattern') then Validation.parse(value) else value

		validated and= Validation.valid $input, noInitialValue: yes

	#validated and= item.unit in ['d','h'] or item.itemPrice

	validated: Boolean(validated)
	item: item
	inputs: inputs


clear = (template, inputs)->
	if inputs
		$input.val('') for $input in inputs when $input.prop('tagName').toLowerCase() isnt 'select'
	else
		for field, inputId of fieldsMapping
			$input = $(template.find "##{inputId}")
			$input.val('') if $input.prop('tagName').toLowerCase() isnt 'select'

	$('#unit').find('option:selected').removeAttr('selected')


Template[templateName].helpers {
	currencyIcon: -> if @currency is '$' then 'usd' else 'euro'
}

Template[templateName].events {

	'blur input, change select': (e, template)->
		do e.stopPropagation
		$(template.find '#add').toggleClass 'hidden', not(validate(template).validated)

	#==================================
	'click #add': (e, template)->
		do e.stopPropagation
		results = validate template
		item = results.item
		inputs = results.inputs

		if results.validated
			Items.insert item
			clear template, inputs
			$(e.target).addClass 'hidden'

	#==================================
	'click #reset': (e, template)->
		do e.stopPropagation
		clear template
		$(template.find '#add').addClass 'hidden'

}