class @Gallery extends Backbone.View

  initUploadButton : () ->
    @$uploadButton = @$el.find('[type="file"]')
    @galleryId = @$el.find('[type="hidden"]').val()
    @galleryClassName = @$uploadButton.data('class-name')
    @$loaderHolder = @$el.find('.upload-item.add')

  initCollectionView : () ->
    @collectionView = GalleryImageCollectionView.init @$el.find('[data-sortable-url]'), @galleryClassName

  bindUpload : () ->
    @$uploadButton.fileupload
      dataType : 'json'
      dropZone : @$el
      url : @$uploadButton.data('url')
      formData :
        gallery_id : @galleryId
        class_name : @galleryClassName
      add : (e, $form) =>
        @showLoader()
        $form.submit().done @_appendUploadResult
      stop : @hideLoader

  showLoader : () ->
    @$loaderHolder.addClass('is-loading')

  hideLoader : () =>
    @$loaderHolder.removeClass('is-loading')

  _appendUploadResult : (result) =>
    $.each result.gallery_images_html, (index, image_html) =>
      @collectionView.addImage $(image_html)

  @init : ($el) ->
    gallery = new this
      el : $el
    gallery.initUploadButton()
    gallery.initCollectionView()
    gallery.bindUpload()

  @initAll : () ->
    $('[data-gallery]').each (index, gallery) =>
      $gallery = $(gallery)
      unless $gallery.data('initialized')
        @init $gallery
        $gallery.data('initialized', true)

  @initPlugin : () =>
    @initAll()

$ ->
  $(document).on 'page:load ready init-plugins', Gallery.initPlugin