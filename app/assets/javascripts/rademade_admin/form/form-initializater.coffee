class @FormInitializer extends Backbone.View

  initForms : () ->
    $('form').each (i, form) ->
      Form.init $(form)

  setErrorsFormatting : () ->
    $.validator.setDefaults

      showErrors : (errorMap, errorList) =>
        $.each errorList, (index, error) =>
          $error = $(error.element)
          @_clearErrors($error)
          @_showErrorMessage($error, error)

  _clearErrors : ($error) ->
    $error.siblings('.error-message').remove()

  _showErrorMessage : ($error, error) ->
    $error.after @_getErrorNotifier(error)

  _getErrorMessage : (error) ->
    if $.isArray(error.message)
      error.message.join('<br>')
    else
      error.message

  _getErrorNotifier : (message) ->
    $([
      '<span class="error-message">'
        @_getErrorMessage(message)
        '<i class="ico error-buble"></i>'
      '</span>'
    ].join(''))


FormInitializer.init = () ->
  formInitializer = new FormInitializer()
  formInitializer.setErrorsFormatting()
  formInitializer.initForms()
  formInitializer


$ ->
  $(document).on 'ready page:load', FormInitializer.init