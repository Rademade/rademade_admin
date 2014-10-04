class @FormValidation extends Backbone.View

  validationObject = undefined

  initialize : (options) ->
    @validationObject = options.validationObject

  displayFieldErrors : (errors) ->
    [messages, globalMessages] = @_collectErrorMessages(errors)
    @_showErrorMessages(messages)
    @_showGlobalErrorMessages(globalMessages)
    false

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
      else
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