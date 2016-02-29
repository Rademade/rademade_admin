class @FilterForm extends Backbone.View

  bindSubmit : () ->
    @$el.on 'submit', (e) =>
      e.preventDefault()
      e.stopImmediatePropagation()
      @_collectFormParams()
      if @formParams.length > 0
        window.location.href = @$el.attr('action') + '?' + @formParams.join('&')

  _collectFormParams : () ->
    @formParams = []
    _.each @$el.serializeArray(), (formParam) =>
      @_pushFormParam(formParam) if formParam.value isnt ''

  _pushFormParam : (formParam) ->
    if formParam.name.substr(-2) is '[]'
      _.each formParam.value.split(','), (value) =>
        @_pushFormParamData formParam.name, value
    else
      @_pushFormParamData formParam.name, formParam.value

  _pushFormParamData : (name, value) ->
    @formParams.push "#{name}=#{value}"

  @init : ($el) =>
    filterForm = new this
      el : $el
    filterForm.bindSubmit()
    filterForm