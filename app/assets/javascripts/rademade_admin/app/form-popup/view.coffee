class @FormPopup.View extends Backbone.View

  className : 'add_new_popup soft-hide'

  events :
    'click' : 'onClick'
    'click .cancel-btn' : 'onReset'

  initialize : () ->
    @model.on 'show', @onShow
    @model.on 'hide', () =>
      @$el.hide()

  onReset : (e) ->
    e.preventDefault()
    @closePopup()

  onClick : (e) ->
    @closePopup() if $(e.target).closest('.simple_form').length is 0

  onShow : () =>
    @$el.show()
    @_updatePosition()

  closePopup : () ->
    @model.destroy()
    @undelegateEvents()
    @$el.remove()

  renderFromUrl : (url) ->
    $.get url, (html) =>
      @$el.html html
      @_updatePosition()
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
    $(document).trigger('init-uploader')
    Select2Input.View.initAll @$el

  _initForm : ($form) ->
    (new FormAjaxSubmit($form)).init()
    $form.on 'ajax-submit-done', (e, data) =>
      $(document).trigger 'form-saved', [@model.get('modelClassName'), data]
      @closePopup()

  _bindButton : () ->
    @$el.find('button').click (e) =>
      @renderFromUrl $(e.currentTarget).data('new')

  _updatePosition : () ->
    @$el.css top : "#{window.pageYOffset}px"


@FormPopup.View.init = (popupModel, url) ->
  popupView = new FormPopup.View
    model : popupModel
  popupView.renderFromUrl url
  popupView