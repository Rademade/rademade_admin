class @ImagePreview extends Backbone.View

  events :
    'click' : 'showPopup'

  initialize : () ->
    @model = new ImagePreviewModel @$el.data()

  showPopup : () ->
    GalleryPopup.getInstance().showForPreview(@model)

  initElements : () ->
    @$holder = @$el.closest('.input-holder')
    @$uploader = @$holder.find('[data-uploader]') # todo another way

  bindUploadChange : () ->
    return if @$uploader.length is 0
    @model.set 'uploadParams', _.pick(@$uploader.data(), 'model', 'column', 'uploader')
    @model.on 'crop', @_onCrop

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