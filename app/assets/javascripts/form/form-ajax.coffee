class @FormAjax extends Backbone.View

  submitHandler : () ->
    @_prepareForAjax()
    $.ajax(
      url : @$el.attr('action')
      type : @$el.data('method') || @$el.attr('method')
      data : @_getData()
      dataType : 'json'
      success: @_onDone
    ).done(@_onDone).fail(@_onFail).always(@_onAlways)

  _prepareForAjax : () ->
    @trigger 'ajax-start'
    for instance of CKEDITOR.instances
      CKEDITOR.instances[instance].updateElement()

  _onDone : (data) =>
    console.log('done')
    @trigger 'ajax-done', data
    window.notifier.notify(data.message) if data.message
    @$el.find('.error-message').remove()

  _onFail : (response) =>
    console.log('_onFail')
    try
      @trigger 'ajax-fail', JSON.parse(response.responseText)

  _onAlways : (response) =>
    data = if (response.responseJSON) then response.responseJSON else response
    @trigger 'ajax-finish', data

  _getData : () ->
    items = @$el.serializeObject()

    for memb of items.data
      array = items.data[memb]
      items.data[memb] = @_cleanArray(array) if $.isArray(array)

    inputMethod = @$el.find('input[name="_method"]')
    items['_method'] = inputMethod.val() if inputMethod instanceof jQuery

    items

  _cleanArray : (array) ->
    newArray = []
    for val in array
      cleanVal = val.trim()
      if cleanVal.length > 0
        newArray = $.merge(newArray, cleanVal.split(','))
    if newArray.length is 0 then [''] else newArray
