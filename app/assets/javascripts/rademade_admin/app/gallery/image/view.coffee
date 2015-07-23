class @GalleryImageView extends Backbone.View

  events :
    'click [data-remove-url]' : 'remove'
#    'click [data-crop]' : 'crop'

  initialize : () ->
    @model.on 'image-removed', @_onImageRemove
#    @_initCrop()

  remove : () ->
    @model.remove() if confirm I18n.t('rademade_admin.remove_confirm.image')

#  crop : () ->
#    @cropper.setOriginalDimensions @model.get('originalDimensions')
#    @cropper.show @model.get('fullUrl')
#    @$el.closest('.input-holder').append @cropper.$el
#
#  _initCrop : () ->
#    @_findCrop()
#    if @$crop.length > 0
#      @_updateModelCropData()
#      @cropper = new Cropper()
#      @cropper.on 'crop-image', @_cropImage
#
#  _cropImage : (cropData) =>
#    @model.crop @$crop.data('url'), cropData, (data) =>
#      @$el.find('img').attr('src', data.gallery_image_url)
#      @_updateCropHtml(data.crop_button_html)
#      @_updateModelCropData()
#
#  _updateModelCropData : () ->
#    @model.set
#      fullUrl : @$crop.data('fullUrl')
#      originalDimensions : @$crop.data('originalDimensions').split(',')
#
#  _updateCropHtml : (html) ->
#    @$crop.replaceWith(html)
#    @_findCrop()
#
#  _findCrop : () ->
#    @$crop = @$el.find('[data-crop]')

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
    new GalleryImageView
      model : model
      el : $el
    model