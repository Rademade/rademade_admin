class @GalleryImageView extends Backbone.View

  events :
    'click' : 'showPopup'
    'click [data-remove-url]' : 'remove'

  initialize : () ->
    @model.on 'image-removed', @_onImageRemove
    @model.on 'change:resizedUrl', @_updateImageUrl

  remove : () ->
    @model.remove() if confirm I18n.t('rademade_admin.remove_confirm.image')
    false

  showPopup : () ->
    GalleryPopup.getInstance().show @model

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
    model.set 'removeUrl', $el.find('[data-remove-url]').data('removeUrl')
    new GalleryImageView
      model : model
      el : $el
    model