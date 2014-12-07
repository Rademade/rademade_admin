class @FormPopup.View extends Backbone.View

  className : 'add_new_popup soft-hide'

  events :
    'click' : 'onClick'
    'click .cancel-btn' : 'onReset'

  onReset : (e) ->
    e.preventDefault()
    @closePopup()

  onClick : (e) ->
    @closePopup() if $(e.target).closest('.simple_form').length is 0

  show : () =>
    @$el.show()
    @_updatePosition()

  hide : () ->
    @$el.hide()

  closePopup : () ->
    @trigger 'close'
    @undelegateEvents()
    @$el.remove()

  renderFromUrl : (url) ->
    @$el.load url, =>
      @_updatePosition()
      @delegateEvents()
      @_init()

  render : () ->
    @renderFromUrl @model.get('edit_url')

  _init : () ->
    $form = @$el.find 'form'
    if $form.length > 0
      $(document).trigger('init-plugins')
      @_initForm $form
    else
      @_bindButton()

  _initForm : ($form) ->
    Form.init $form
    $form.on 'ajax-submit-done', (e, response) =>
      @model.update response.data
      @closePopup()

  _bindButton : () ->
    @$el.find('button').click (e) =>
      @model.set 'edit_url', $(e.currentTarget).data('new')
      @render()

  _updatePosition : () ->
    @$el.css top : "#{window.pageYOffset}px"

  @init : (model) ->
    popupView = new FormPopup.View
      model : model
    popupView.render()
    popupView
