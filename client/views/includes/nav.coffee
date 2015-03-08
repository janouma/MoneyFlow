Template.nav.helpers {
	activeRouteClass: (routeNames...)->
		activeRoutePattern = new RegExp "^(\w{2}\/)?#{Router.current()?.route.getName()}\/?"
		# routeNames[0...] gets rid of the hash added by spacebars
		return 'active' for route in routeNames[0...] when activeRoutePattern.test route
}
