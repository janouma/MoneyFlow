ServiceConfiguration.configurations.upsert(
	{service: 'google'}
	{$set:
		clientId: '235933330616.apps.googleusercontent.com'
		secret: 'wBz378d9vxm_UN8dwM5RcX71'}
)

ServiceConfiguration.configurations.upsert(
		{service: 'twitter'}
		{$set:
			consumerKey: 'XXX'
			secret: 'XXX'}
)