Router.configure(
    layoutTemplate: 'layout'
)

Router.map ->
    @route(
        'home'
        path: '/'
    )
    
    @route(
        'invoices'
        path: '/invoices'
    )
    
    @route(
        'orders'
        path: '/orders'
    )
    
    @route(
        'clients'
        path: '/clients'
    )
    
    @route(
        'settings'
        path: '/settings'
    )