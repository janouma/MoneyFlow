Template.footer.helpers(
    activeLangClass: (lang)-> 'active color-black' if lang is Session.get('lang')
)