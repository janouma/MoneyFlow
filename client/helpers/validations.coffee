emailPattern = /^[.-_\w]+@[.-_\w]+$/i
numberPattern = /^\d+(,|\.)?\d*$/
datePattern = /^\d{2}\/\d{2}\/\d{4}$/

@Validation =
	valid: ($input)->
		return false unless $input
		emailPattern.lastIndex = 0
		value = $input.val().trim()
		validated = value.length or $input.attr('data-initial-value')?.length
		validated and= value isnt $input.attr('data-initial-value')
		validated and= not ($input.attr('required')) or value.length
		validated and= not (value.length) or not ($input.attr('pattern')) or (new RegExp $input.attr('pattern')).test(value)
		validated and= not (value.length) or $input.attr('type') isnt 'email' or emailPattern.test(value)

	parse: (value)->
		numberPattern.lastIndex = 0
		datePattern.lastIndex = 0

		switch
			when numberPattern.test value then parseFloat(value.replace /,/g, '.')
			when datePattern.test value then moment(value, App.dateFormat).toDate()
			else value
