templateName = 'invoiceEdit'

#Template[templateName].invoicesAreAvailable = -> AccountingDocuments.findOne(documentType: 'i')

Template[templateName].helpers {
	invoicesAreAvailable: -> AccountingDocuments.findOne(documentType: 'i')
	invoice: ->
		if Router.current().params._id
			AccountingDocuments.findOne(_id: Router.current().params._id)
}

Template[templateName].events {
	'submit form': (e)-> do e.preventDefault

	#==================================
	'blur input, blur textarea, change select, change input[type=checkbox]': (e, template)->
		$input = $(e.target)

		if Validation.valid $input
			field = $input.attr 'id'
			invoice =
				field: field
				value: $input.val().trim()

			invoice.value = Validation.parseFloat invoice.value

			if Router.current().params._id
				invoice._id = Router.current().params._id
			else
				invoice.documentType = 'i'

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