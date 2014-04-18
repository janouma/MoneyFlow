Meteor.publish 'settings', (userId)-> Settings.find userId: userId
Meteor.publish 'clients', (userId)-> Clients.find userId: userId
Meteor.publish 'invoices', (userId)-> AccountingDocuments.find(userId: userId, documentType: 'i')