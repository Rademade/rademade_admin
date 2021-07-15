class @GalleryImageView extends Backbone.View

  events :
    'click' : 'showPopup'
    'click [data-remove]' : 'remove'

  initialize : () ->
    @model.on 'image-removed', @_onImageRemove
    @model.on 'change:resizedUrl', @_updateImageUrl

  remove : () ->
    @model.remove()
    false

  showPopup : () ->
    GalleryPopup.getInstance().showForGallery @model

  _onImageRemove : () =>
    fadeTime = 300
    @$el.fadeOut fadeTime
    setTimeout () =>
      @$el.remove()
    , fadeTime

  _updateImageUrl : () =>
    @$el.find('img').attr 'src', @model.get('resizedUrl')

  @init : ($el) ->
    model = new GalleryImageModel $el.data()
    new GalleryImageView
      model : model
      el : $el
    model
