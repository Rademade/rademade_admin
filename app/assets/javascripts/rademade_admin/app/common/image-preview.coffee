class @ImagePreview extends Backbone.View

  bindReview : ($imagePreview) ->
    @model = new ImagePreviewModel $imagePreview.data()
    $imagePreview.click () =>
      GalleryPopup.getInstance().showForPreview(@model)

  bindUploadChange : ($holder) ->
    $uploader = $holder.find('[data-uploader]') # todo another way
    return if $uploader.length is 0
    @model.set 'uploadParams', _.pick $uploader.data(), 'model', 'column', 'uploader'
    @model.on 'crop', () =>
      $holder.find('img').attr 'src', @model.get('resizedUrl')
      $holder.find('input[type="hidden"]').val @model.get('fullUrl')

  @init : ($imagePreview) ->
    imagePreview = new this
    imagePreview.bindReview $imagePreview
    imagePreview.bindUploadChange $imagePreview.closest('.input-holder')
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