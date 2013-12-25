Template.nav.helpers(
    activeRouteClass: (routeNames...)-> 'active' if Router.current().route.name in routeNames[0...] # Get rid of the hash added by handlebars
)