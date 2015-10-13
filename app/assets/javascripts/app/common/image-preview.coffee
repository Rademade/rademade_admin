class @ImagePreview extends Backbone.View

  events :
    'click' : 'showPopup'

  initialize : () ->
    @model = new ImagePreviewModel @$el.data()

  showPopup : () ->
    $popup = GalleryPopup.getInstance().showForPreview(@model)
    @$galleryPopup = $popup.find('.popup-gallery')
    @centerImage()

  initElements : () ->
    @$holder = @$el.closest('.input-holder')
    @$uploader = @$holder.find('[data-uploader]') # todo another way
    @$window = $(window)

  bindUploadChange : () ->
    return if @$uploader.length is 0
    @model.set 'uploadParams', _.pick(@$uploader.data(), 'model', 'column', 'uploader')
    @model.on 'crop', @_onCrop

  centerImage : () ->
    @$galleryPopup.find('.popup-gallery-img').on 'load', @_centerImage
    @$window.on 'resize', @_centerImage

  _centerImage : () =>
    heightWithouImage = @$window.height() - @$galleryPopup.find('.popup-gallery-img').outerHeight()
    @$galleryPopup.css 'margin-top', heightWithouImage / 2 - @$galleryPopup.position().top

  _onCrop : () =>
    @$holder.find('img').attr 'src', @model.get('resizedUrl')
    @$holder.find('input[type="hidden"]').val @model.get('fullUrl')

  @init : ($imagePreview) ->
    imagePreview = new this
      el : $imagePreview
    imagePreview.initElements()
    imagePreview.bindUploadChange()
    imagePreview

  @initAll : () ->
    $('[data-image-preview]').each (index, el) =>
      $imagePreview = $(el)
      unless $imagePreview.data('initialized')
        @init $imagePreview
        $imagePreview.data('initialized', true)

  @initPlugin : () =>
    @initAll()

$ ->
  $(document).on 'page:load ready init-plugins', ImagePreview.initPlugin