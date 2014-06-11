class @FormPopup.View extends Backbone.View

  className : 'add_new_popup soft-hide'

  events :
    'click .reset' : 'onReset'

  initialize : () ->
    @model.on 'show', () =>
      @$el.show()
    @model.on 'hide', () =>
      @$el.hide()

  onReset : (e) ->
    e.preventDefault()
    @closePopup()

  closePopup : () ->
    @model.destroy()
    @undelegateEvents()
    @$el.remove()

  renderFromUrl : (url) ->
    $.get url, (html) =>
      @$el.html html
      @delegateEvents()
      @_init()

  _init : () ->
    $form = @$el.find 'form'
    if $form.length > 0
      @_initPlugins()
      @_initForm $form
    else
      @_bindButton()

  _initPlugins : () ->
    $(document)
      .trigger('init-select')
      .trigger('init-uploader')

  _initForm : ($form) ->
    (new FormAjaxSubmit($form)).init()
    $form.on 'ajax-submit-done', (e, data) =>
      $(document).trigger 'form-saved', [@model.get('modelClassName'), data]
      @closePopup()

  _bindButton : () ->
    @$el.find('button').click (e) =>
      @renderFromUrl $(e.currentTarget).data('new')


@FormPopup.View.init = (popupModel, url) ->
  popupView = new FormPopup.View
    model : popupModel
  popupView.renderFromUrl url
  popupView