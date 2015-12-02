initForms = () ->
  FormValidation.initDefaults()
  $('form').each (i, form) ->
    $form = $(form)
    Form.init $form unless $form.data().disableAdmin

$ ->
  $(document).on 'ready page:load init-plugins', initForms