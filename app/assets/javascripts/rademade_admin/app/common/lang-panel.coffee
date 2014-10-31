initLangPanel = () ->
  $langPanel = $('[data-lang-panel]')
  $langPanel.tabs() if $langPanel.length > 0

$ ->
  $(document).on 'ready page:load init-plugins', initLangPanel
