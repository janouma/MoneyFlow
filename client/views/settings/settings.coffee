templateName = 'settings'

focus = (e, template) ->
	$field = $(e.target)
	$tip = $(template.find(".form-tip[for=#{$field.attr('id')}]"))
	$tip.addClass('visible')

mouseenter = (e, template) ->
	$field = $(e.target).addClass 'focus'
	$tip = $(template.find(".form-tip[for=#{$field.attr('id')}]"))
	$tip.removeClass('hidden')

blur = (e, template) ->
	$field = $(e.target)
	$tip = $(template.find(".form-tip[for=#{$field.attr('id')}]"))
	$tip.removeClass 'visible'

mouseleave = (e, template) ->
	$field = $(e.target).removeClass 'focus'
	$tip = $(template.find(".form-tip[for=#{$field.attr('id')}]"))
	$tip.addClass 'hidden'

Template[templateName].helpers {
	taxerate: -> App.taxerate
}

Template[templateName].events {
	"focus input[type]": focus
	"mouseenter input[type]": mouseenter
	"focus textarea": focus
	"mouseenter textarea": mouseenter
	"blur input[type]": blur
	"mouseleave input[type]": mouseleave
	"blur textarea": blur
	"mouseleave textarea": mouseleave
}