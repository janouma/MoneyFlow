initialTranslations =
    fr:
        home: 'accueil'
        invoice: 'facture'
        order: 'commande'
        client: 'client'
        setting: ['paramètre', 'paramétrages']
        download: 'télécharger'  
        signin:'connexion'
        french: 'français'
        english: 'english'
        resourceNotFound: 'ressource introuvable'
        resourceNotFoundBody: 'La ressource demandée est introuvable sur ce serveur'
        translationAdmin: 'gestionnaire des traductions'
        
    en:
        home: 'home'
        order: 'order'
        setting: 'setting'
        download: 'download'
        signin: 'sign in'
        resourceNotFound: 'resource not found'
        resourceNotFoundBody: 'The requested resource cannot be found on this server'
        translationAdmin: 'translation manager'

    
initialTranslations.fr.fr = initialTranslations.fr.french
initialTranslations.fr.en = initialTranslations.fr.english

I18nEasy.publish initialTranslations