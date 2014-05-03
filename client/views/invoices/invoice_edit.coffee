templateName = 'invoiceEdit'

invoiceDefaults =
	taxerate: yes
	documentType: 'i'
	invoiceDate: new Date()
	currency: '€'


addDefaultsTo = (invoice)->
	defaults = {}
	hasDefaults = 0

	for property, value of invoiceDefaults when property isnt invoice.field
		hasDefaults++
		defaults[property] = value

	invoice.defaults = defaults if hasDefaults


fetchers =
	client: ($select)-> clientName: $select.find('option:selected').text()

fetchDataFrom = ($input)-> (fetchers[$input.attr 'id'])?($input)


Template[templateName].helpers {
	invoicesAreAvailable: -> AccountingDocuments.findOne(documentType: 'i')
	invoice: ->
		if Router.current().params._id
			AccountingDocuments.findOne(_id: Router.current().params._id)

	items: -> Items.find documentId: Router.current().params._id
}

Template[templateName].events {
	'submit form': (e)-> do e.preventDefault

	#==================================
	'blur input, blur textarea, change select, change input[type=checkbox]': (e, template)->
		$input = $(e.target)

		if Validation.valid $input
			field = $input.attr 'id'
			invoice = field: field

			if $input.attr('type') is 'checkbox'
				if $input.prop('checked')
					invoice.value = $input.attr("value") or yes
			else
				value = $input.val().trim()
				if value.length
					invoice.value = if $input.attr('pattern') then Validation.parse(value) else value

			if Router.current().params._id
				invoice._id = Router.current().params._id
			else
				addDefaultsTo invoice

			linkedData = fetchDataFrom $input
			invoice.linkedData = linkedData if linkedData

			$label = $(template.find "label[for=#{$input.attr 'id'}]")
			$formLabel = $label.parent '.form-label'

			Meteor.call(
				'updateAccountingDocument'
				invoice
				(error, newId)->
					errorColorClass = 'color-error'
					errorThemeClass = 'theme-error'

					if error
						$formLabel.addClass(errorThemeClass)
						$label.addClass(errorColorClass)
					else
						if invoice._id
							$formLabel.removeClass(errorThemeClass)
							$label.removeClass(errorColorClass)
						else
							Router.go 'invoices', _id: newId
			)
}