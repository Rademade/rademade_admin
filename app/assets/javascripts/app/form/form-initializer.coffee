initForms = () ->
  FormValidation.initDefaults()
  $('form').each (i, form) ->
    $form = $(form)
    Form.init($form) unless $form.data('disableAdmin')
    FilterForm.init($form) if $form.data('form') is 'filter'

$ ->
  $(document).on 'ready page:load init-plugins', initForms