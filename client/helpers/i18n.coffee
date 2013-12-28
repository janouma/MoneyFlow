DEFAULT_LANG = 'fr'

messages =
    home:
        fr: 'accueil'
        en: 'home'

    invoice:
        fr: 'facture'

    order:
        fr: 'commande'
        en: 'order'

    client: 'client'

    setting: 
        fr: ['paramètre', 'paramétrages']
        en: 'setting'

    download:
        fr: 'télécharger'
        en: 'download'
        
    signin:
        fr: 'connexion'
        en: 'sign in'
        
    french: 'français'
    english: 'english'
    
    resourceNotFound:
        fr: 'ressource introuvable'
        en: 'resource not found'


translationFor = (messageId)->
    currentLang = Session.get('lang') or DEFAULT_LANG
    messages[messageId]?[currentLang] or messages[messageId]?[DEFAULT_LANG] or messages[messageId]


singularFor = (messageId)->
    message = translationFor messageId
    if message?.constructor.name is 'Array'
        message[0]
    else
        message

        
pluralFor = (messageId)->
    message = translationFor messageId
    if message?.constructor.name is 'Array'
        message[1]
    else
        "#{message}s"
        

Handlebars.registerHelper(
    'i18n'
    (messageId)->
        message = singularFor messageId
        unless message
            if /s$/i.test messageId then pluralFor messageId[0...messageId.length-1] else "{{#{messageId}}}"
        else
            message
)