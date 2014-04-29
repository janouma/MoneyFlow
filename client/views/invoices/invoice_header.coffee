Template.invoiceHeader.helpers {
	selectedClient: (currentClient, invoiceClient)-> yes if currentClient is invoiceClient
	invoiceClient: -> Clients.findOne _id: @client if @_id and @client
}