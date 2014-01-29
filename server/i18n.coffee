###
{
   "en":{
      "add":"add",
      "cancel":"cancel",
      "delete":"delete",
      "download":"download",
      "duplicatedKey":"the key already exists",
      "duplicatedLanguage":"the language already exists",
      "home":"home",
      "internalServerError":[
         "an error occurred server side",
         "several errors occurred server side"
      ],
      "invoice":"invoice",
      "newKey":"new key",
      "newLanguage":"new language",
      "nothingToSave":"there is nothing worth saving",
      "order":"order",
      "plural":"plural",
      "processing":"processing ...",
      "resourceNotFound":[
         "resource not found",
         "resources not found"
      ],
      "resourceNotFoundBody":"the requested resource cannot be found on this server",
      "save":"save",
      "setting":"setting",
      "signin":"sign in",
      "singular":"singular",
      "successful":"everything went well",
      "translationAdmin":"translation manager",
      "unknownError":"an unknown error occurred"
   },
   "fr":{
      "add":"ajouter",
      "cancel":"annuler",
      "client":"client",
      "delete":"supprimer",
      "download":"télécharger",
      "duplicatedKey":"la clé existe déjà",
      "duplicatedLanguage":"la langue existe déjà",
      "en":"english",
      "export":"exporter",
      "fr":"français",
      "home":"accueil",
      "internalServerError":"une erreur est survenue côté serveur",
      "invoice":"facture",
      "newKey":"nouvelle clé",
      "newLanguage":"nouvelle langue",
      "nothingToSave":"rien ne vaut la peine d'être enregistré",
      "order":"commande",
      "plural":"pluriel",
      "processing":[
         "traitement en cours ...",
         "traitements en cours ..."
      ],
      "resourceNotFound":"ressource introuvable",
      "resourceNotFoundBody":"la ressource demandée est introuvable sur ce serveur",
      "save":"enregistrer",
      "setting":"paramètre",
      "signin":"connexion",
      "singular":"singulier",
      "successful":"tout s'est bien passé",
      "translationAdmin":"gestionnaire des traductions",
      "unknownError":[
         "une erreur inconnue est survenue",
         "plusieurs erreurs inconnues sont survenues"
      ]
   }
}
###



initialTranslations =
	fr:
		fr: 'français'
		en: 'english'
		home: 'accueil'
		invoice: 'facture'
		order: 'commande'
		client: 'client'
		setting: 'paramètre'
		download: 'télécharger'
		signin: 'connexion'
		resourceNotFound: 'ressource introuvable'
		resourceNotFoundBody: 'la ressource demandée est introuvable sur ce serveur'
		translationAdmin: 'gestionnaire des traductions'
		save: 'enregistrer'
		add: 'ajouter'
		singular: 'singulier'
		plural: 'pluriel'
		newKey: 'nouvelle clé'

	en:
		home: 'home'
		invoice: 'invoice'
		order: 'order'
		setting: 'setting'
		download: 'download'
		signin: 'sign in'
		resourceNotFound: 'resource not found'
		resourceNotFoundBody: 'the requested resource cannot be found on this server'
		translationAdmin: 'translation manager'
		save: 'save'
		add: 'add'
		singular: 'singular'
		plural: 'plural'
		newKey: 'new key'


I18nEasy.publish {
	default: 'fr'
	translations: initialTranslations
}