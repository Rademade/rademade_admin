class @GalleryImageView extends Backbone.View

  events :
    'click .remove-ico' : 'remove'

  initialize : () ->
    @model.on 'image-removed', @_onImageRemove

  remove : () ->
    @model.remove() if confirm I18n.t('rademade_admin.image_remove_confirm')

  _onImageRemove : () =>
    fadeTime = 300
    @$el.fadeOut fadeTime
    setTimeout () =>
      @$el.remove()
    , fadeTime

  @init : ($el) ->
    model = new GalleryImageModel
      imageId : $el.data('id')
      removeUrl : $el.find('.remove-ico').data('url')
    new GalleryImageView
      model : model
      el : $el
    model