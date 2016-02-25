class @FilterForm extends Backbone.View

  bindSubmit : () ->
    @$el.on 'submit', (e) =>
      e.preventDefault()
      e.stopImmediatePropagation()
      formParams = []
      _.each @$el.serializeArray(), (formParam) ->
        if formParam.value isnt ''
          formParams.push formParam.name + '=' + formParam.value
      if formParams.length > 0
        window.location.href = @$el.attr('action') + '?' + formParams.join('&')

  @init : ($el) =>
    filterForm = new this
      el : $el
    filterForm.bindSubmit()
    filterForm