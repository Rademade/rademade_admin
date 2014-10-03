window.FormAjaxSubmit = ($form) ->
	@_$form = $form
	@_validationObject = null
	@_sending = false

(->

  #@trigger ['ajax-before-submit', 'ajax-submit-done', 'ajax-submit-fail', 'ajax-submit-always']

  FormAjaxSubmit::init = ->

    validation_data = @__getValidationData()
    @__loadValidationRules validation_data
    @_validationObject = @_$form.validate(validation_data)

  FormAjaxSubmit::displayFieldErrors = (errors) ->
    messages = {}
    globalMessages = []

    $.each errors, (field, message) =>
      name = "data[#{field}]"
      if $("[name='#{name}']").length > 0
        messages[name] = message
      else
        _.each message, (subMessage) ->
          globalMessages.push "#{field} #{subMessage}"

    unless $.isEmptyObject(messages)
      try
        @_validationObject.showErrors messages
      catch e
        @displayGlobalErrors messages
      return true

    unless messages.length is 0
      @displayGlobalErrors globalMessages

    false

  FormAjaxSubmit::displayGlobalErrors = (errors) ->
    errorMessage = ''
    _.each errors, (error) ->
      errorMessage += "<p>#{error}</p>"
    window.notifier.notify errorMessage


  FormAjaxSubmit::.__loadValidationRules = (validation_data) ->
    #TODO load custom validation


  FormAjaxSubmit::__getValidationData = ->
    _self = this

    highlight: (element) ->
      $(element).parent().removeClass('success').addClass 'error'

    unhighlight: (element) ->
      $(element).parent().removeClass('error').addClass 'success'

    submitHandler: ->
      return if _self._sending
      lazySubmitHandler = -> _self._submitHandler()
      if _self.handlerExist('ajax-before-submit')
        _self.trigger('ajax-before-submit', [ lazySubmitHandler ])
      else
        lazySubmitHandler.call()
      return false


  FormAjaxSubmit::__processFormError = (data) ->
    showFieldErrors = @displayFieldErrors(data.errors)
    console.log showFieldErrors unless showFieldErrors

  FormAjaxSubmit::__removeFormErrors = ->
    @_$form.find('.error-message').remove()

  FormAjaxSubmit::_submitHandler = ->
    for instance of CKEDITOR.instances
      CKEDITOR.instances[instance].updateElement()

    @_sending = true
    _self = this
    items = @_$form.serializeObject()

    # Workaround for select2 values serialization
    # It finds all 'array' members of data hash,
    # and splits their values by ',', cleaning all
    # non-space characters.
    #todo extract. All class need super refactoring. Sergey, you can do it :)
    for memb of items.data
      array = items.data[memb]
      if $.isArray(array)
        newArray = []

        for val in array
          cleanVal = val.replace(/\s+/g,'')
          if cleanVal.length > 0
            newArray = $.merge(newArray, cleanVal.split(','))

        items.data[memb] = if newArray.length is 0 then [''] else newArray

    input_method = @_$form.find('input[name="_method"]')
    items['_method'] = input_method.val() if input_method instanceof jQuery

    $.ajax(
      url: @_$form.attr('action')
      type: @_$form.attr('method')
      data: items
      dataType: 'json'
    ).done((data) ->
      _self.trigger('ajax-submit-done', [data])
      $(document).trigger('ajax-submit-done', [data]) #rm_todo remove global events
      _self.__removeFormErrors()
    ).fail((response) ->
      try
        data = JSON.parse( response.responseText )
        _self.trigger('ajax-submit-fail', [data])
        _self.__processFormError( data )
      #rm_todo error catching.
      #rm_todo extract fail process method
    ).always (response) ->
      data = if (response.responseJSON) then response.responseJSON else response
      window.notifier.notify(data.message) if data.message
      _self.trigger('ajax-submit-always', [data])
      _self._sending = false

  FormAjaxSubmit::trigger = ->
    @_$form.triggerHandler.apply(@_$form, arguments)

  FormAjaxSubmit::handlerExist = (name)->
    jQuery._data( @_$form[0] ).events[ name ]

  @
)()

formatingErrors = ->
  $.validator.setDefaults showErrors: (errorMap, errorList) ->

    $.each errorList, (index, error) ->

      $(error.element).parent().children('.error-message').remove()

      if $.isArray(error.message)
        message = error.message.join('<br>')
      else
        message = error.message

      notify = $([
        '<span class="error-message">'
          message
          '<i class="ico error-buble"></i>'
        '</span>'
      ].join(''))

      $(error.element).after notify
      return

  return

setupFormSubmit = -> 
  
  formatingErrors.call()

  $('form').each (i, form) ->
    (new FormAjaxSubmit($(form))).init()

$ ->
  $(document).on 'ready page:load', setupFormSubmit