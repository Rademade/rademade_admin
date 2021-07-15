class @FormValidation extends Backbone.View

  validationObject = undefined

  initialize : (options) ->
    @validationObject = options.validationObject

  displayFieldErrors : (errors) ->
    if _.isArray(errors) || _.isObject(errors)
      [messages, globalMessages] = @_collectErrorMessages(errors)
      @_showErrorMessages(messages)
      @_showGlobalErrorMessages(globalMessages)
    else
      window.notifier.notify errors
    false

  clearFieldErrors : () ->
    $form = $(@validationObject.currentForm)
    $form.find('.in-error').removeClass('in-error')
    $form.find('.error-message').remove()

  displayGlobalErrors : (errors) ->
    errorMessage = ''
    _.each errors, (error) ->
      errorMessage += "<p>#{error}</p>"
    window.notifier.notify errorMessage

  _collectErrorMessages : (errors) ->
    messages = {}
    globalMessages = []

    $.each errors, (field, message) ->
      name = "data[#{field}]"
      if $("[name='#{name}']").length > 0
        messages[name] = message
      else if $("[name='#{name}[]']").length > 0
        messages["#{name}[]"] = message
      else
        $("[name*='#{name}']").each (index) ->
          messages[@name] = ''
        _.each message, (subMessage) ->
          globalMessages.push "#{field} #{subMessage}"

    [messages, globalMessages]

  _showErrorMessages : (messages) ->
    unless $.isEmptyObject(messages)
      try
        @validationObject.showErrors messages
      catch e
        @displayGlobalErrors messages

  _showGlobalErrorMessages : (messages) ->
    @displayGlobalErrors(messages) unless messages.length is 0

  @initDefaults : () ->
    $.validator.setDefaults
      showErrors : (errorMap, errorList) =>
        wasScrolledToError = false
        _.each errorList, (error) =>
          $element = $(error.element)
          $holder = $element.closest('.input-holder')
          $holder.addClass 'in-error'
          $holder.append @_getErrorNotifier(error)
          $element.on 'input change select2:select', () ->
            $holder.removeClass('in-error')
            $holder.find('.error-message').remove()
          if error.element.type == 'hidden'
            $holder.on 'click', () ->
              $holder.removeClass('in-error')
              $holder.find('.error-message').remove()
          unless wasScrolledToError
            wasScrolledToError = true
            $('html, body').animate({
              scrollTop : $holder.offset().top - 50
            }, 500)

  @_getErrorNotifier : (message) ->
    $([
      '<span class="error-message">'
        @_getErrorMessage(message)
        '<i class="ico error-buble"></i>'
      '</span>'
    ].join(''))

  @_getErrorMessage : (error) ->
    if $.isArray(error.message)
      error.message.join('<br>')
    else
      error.message
