class @FormPopup.Initializer extends Backbone.View

  _popupViews : []

  showPopup : (model) ->
    popupView = FormPopup.View.init model
    @addPopup popupView
    @$el.append popupView.$el

  addPopup : (popup) ->
    popup.on 'close', @_onPopupClose
    @_last().hide() if @_hasPopups()
    @_popupViews.push popup

  _onPopupClose : () =>
    @_popupViews.pop()
    @_last().show() if @_hasPopups()

  _last : () ->
    _.last @_popupViews

  _hasPopups : () ->
    @_popupViews.length > 0


  @getInstance : () ->
    instance = null
    do () ->
      instance ||= new @FormPopup.Initializer
        el : document.getElementById 'pad-wrapper'