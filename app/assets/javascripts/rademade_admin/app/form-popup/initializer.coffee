class @FormPopup.Initializer extends Backbone.View

  _popups : undefined

  events :
    'click .relation-add-button' : 'onRelationAdd'
    'click [data-edit]' : 'onRelationEdit'

  initialize : () ->
    @_popups = new FormPopup.Collection

  onRelationAdd : (e) ->
    e.preventDefault()
    $button = $ e.currentTarget
    @showPopup $button.data('class'), $button.data('new')

  onRelationEdit : (e) ->
    e.preventDefault()
    $button = $ e.currentTarget
    @showPopup $button.closest('.input-holder').find('.select-wrapper').data('rel-class'), $button.data('edit') # REVIEW

  showPopup : (modelClassName, url) ->
    popupModel = @_popups.getModelWithClass modelClassName
    if popupModel
      @_popups.showModel popupModel
    else
      @createPopup modelClassName, url

  createPopup : (modelClassName, url) ->
    popupModel = new FormPopup.Model
      modelClassName : modelClassName
    popupView = FormPopup.View.init popupModel, url
    @_popups.add popupView.model
    @$el.append popupView.$el

formPopup = undefined

$(document).on 'ready page:load', () =>
  formPopup = new @FormPopup.Initializer
    el : document.getElementById 'pad-wrapper'

$(document).on 'show:popup', (e, modelClassName, url) =>
  formPopup.showPopup modelClassName, url