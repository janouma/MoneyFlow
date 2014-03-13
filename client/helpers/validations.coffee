@Validation =
	valid: ($input)->
		return false unless $input
		value = $input.val().trim()
		validated = value isnt $input.attr('data-initial-value')
		validated and= not $input.attr('required') or value.length
		validated and= not value.length or not $input.attr('pattern') or (new RegExp $input.attr('pattern')).test(value)
		validated and= not value.length or $input.attr('type') isnt 'email' or (/^[.-_\w]+@[.-_\w]+$/i).test(value)