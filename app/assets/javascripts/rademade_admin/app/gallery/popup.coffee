class @GalleryPopup extends Backbone.View

  events :
    'click [data-gallery-prev]' : 'previousPhoto'
    'click [data-gallery-next]' : 'nextPhoto'
    'click [data-gallery-remove]' : 'removePhoto'
    'click [data-gallery-crop]' : 'cropPhoto'
    'click [data-popup-close]' : 'close'

  showForGallery : (model) ->
    @_setCurrentPhoto model
    @currentGallery = model.collection
    @hasPhotos = @currentGallery.length > 1
    @hasCrop = model.get('crop') isnt undefined
    @render()

  showForPreview : (model) ->
    @_setCurrentPhoto model
    @hasPhotos = false
    @hasCrop = model.get('crop') and model.get('uploadParams')
    @render()

  render : () ->
    @$popup = $ @_getHTML()
    @_initCrop()
    @$el.append @$popup

  previousPhoto : () ->
    photoIndex = @currentGallery.indexOf @currentPhoto
    if photoIndex <= 0
      photoIndex = @currentGallery.length - 1
    else
      photoIndex--
    @_changePhoto photoIndex

  nextPhoto : () ->
    photoIndex = @currentGallery.indexOf @currentPhoto
    if photoIndex >= @currentGallery.length - 1
      photoIndex = 0
    else
      photoIndex++
    @_changePhoto photoIndex

  removePhoto : () ->
    if confirm I18n.t('rademade_admin.remove_confirm.image')
      @currentPhoto.on 'image-removed', @_onImageRemove
      @currentPhoto.remove()

  cropPhoto : () ->
    cropAttributes = @cropper.getCropAttributes()
    @currentPhoto.crop(cropAttributes) if cropAttributes isnt undefined

  close : (e) ->
    e.preventDefault()
    @closePopup()

  closePopup : () ->
    @$popup.remove()
    @_unbindEvents()
    @undelegateEvents()

  _onImageRemove : () =>
    if @hasPhotos
      @hasPhotos = @currentGallery.length > 1
      @nextPhoto()
    else
      @closePopup()

  _initCrop : () ->
    @cropper = Cropper.init(@$popup.find('img'), @currentPhoto) if @hasCrop

  _changePhoto : (photoIndex) ->
    @_setCurrentPhoto @currentGallery.at(photoIndex)
    @_updateHTML()

  _setCurrentPhoto : (photo) ->
    @_unbindEvents()
    @currentPhoto = photo
    @currentPhoto.on 'crop', @_updateHTML

  _unbindEvents : () ->
    @currentPhoto.off('crop') if @currentPhoto

  _updateHTML : () =>
    @$popup.html @_getHTML()
    @_initCrop()

  _getHTML : () ->
    JST['rademade_admin/app/templates/gallery-popup']
      photo : @currentPhoto.toJSON()
      hasPhotos : @hasPhotos
      hasCrop : @hasCrop

  @getInstance : () ->
    instance = null
    do () ->
      instance ||= new @GalleryPopup
        el : document.querySelector 'body'