class @Form extends Backbone.View

  sending = false
  formValidation = undefined
  formAjax = undefined

  initValidationObject : () ->
    @formValidation = new FormValidation
      validationObject : @$el.validate @getValidationData()

  initFormAjax : () ->
    @formAjax = new FormAjax
      el : @$el
    @formAjax.on('ajax-start', @_onAjaxStart)
      .on('ajax-done', @_onAjaxDone)
      .on('ajax-fail', @_onAjaxFail)
      .on('ajax-finish', @_onAjaxFinish)

  getValidationData : () ->
    submitHandler : () =>
      return if @sending
      lazySubmitHandler = () =>
        @formAjax.submitHandler()
      if @handlerExist('ajax-before-submit')
        @trigger('ajax-before-submit', [ lazySubmitHandler ])
      else
        lazySubmitHandler.call()
      return false

  handlerExist : (name) ->
    jQuery._data(@el).events[name]

  trigger : () ->
    @$el.triggerHandler.apply(@$el, arguments)

  _onAjaxStart : () =>
    $('#loader').removeClass('hide')
    @formValidation.clearFieldErrors()
    @sending = true

  _onAjaxDone : (data) =>
    if data.with_return
      Content.getInstance().moveToPreviousContentItem()
    else
      @trigger 'ajax-submit-done', [data]

  _onAjaxFail : (data) =>
    @trigger 'ajax-submit-fail', [data]
    @formValidation.displayFieldErrors(data.errors)

  _onAjaxFinish : (data) =>
    $('#loader').addClass('hide')
    @trigger 'ajax-submit-always', [data]
    @sending = false


Form.init = ($el) ->
  form = new Form
    el : $el
  form.initValidationObject()
  form.initFormAjax()
  form
