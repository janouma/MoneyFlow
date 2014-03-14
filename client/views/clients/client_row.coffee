templateName = 'clientRow'

Template[templateName].helpers {
	activeRowClass: (client)-> 'active-row' if client._id is Router.current().params._id
}

Template[templateName].events {
	'click tr.clickable': (e, template)-> Router.go 'clients', @
}