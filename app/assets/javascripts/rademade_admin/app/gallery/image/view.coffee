class @GalleryImageView extends Backbone.View

  events :
    'click' : 'showPopup'
    'click [data-remove-url]' : 'remove'

  initialize : () ->
    @model.on 'image-removed', @_onImageRemove

  remove : () ->
    @model.remove() if confirm I18n.t('rademade_admin.remove_confirm.image')
    false

  showPopup : () ->
#    @galleryPopup.show()
#    @$el.closest('.input-holder').append @imagePopup.$el

  _onImageRemove : () =>
    fadeTime = 300
    @$el.fadeOut fadeTime
    setTimeout () =>
      @$el.remove()
    , fadeTime

  @init : ($el) ->
    model = new GalleryImageModel
      imageId : $el.data('id')
      removeUrl : $el.find('[data-remove-url]').data('remove-url')
      cropData : $el.data('crop')
    new GalleryImageView
      model : model
      el : $el
    model