Template.clients.helpers {
	clientEdition: ->
		truth = Router.current().params._id
		truth and= Clients.findOne {_id: Router.current().params._id}
		truth or= Router.current().params.query.new
		truth or= not Clients.find().count()

	listOptions: ->
		template: Template.clientsList
		item: 'client'
		collection: Clients
}
