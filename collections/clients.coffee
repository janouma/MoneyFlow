@Clients = new Meteor.Collection 'clients'

@Clients.allow {
	insert: ownsDocument
	update: ownsDocument
}