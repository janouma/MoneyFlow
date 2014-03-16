Template.layout.events {
	'click input[type=checkbox]': (e)->
		$checkbox = $(e.target)
		$checkboxStyle = $checkbox.parent '.checkbox-style'

		$checkboxStyle.toggleClass(
			'checked'
			$checkbox.val()
		)
}