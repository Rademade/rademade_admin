initForms = () ->
  FormValidation.initDefaults()
  $('form').each (i, form) ->
    Form.init $(form)

$ ->
  $(document).on 'ready page:load init-plugins', initForms