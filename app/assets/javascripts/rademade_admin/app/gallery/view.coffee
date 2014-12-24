class @Gallery extends Backbone.View

  initUploadButton : () ->
    @$uploadButton = @$el.find('.gallery-image-upload')
    @galleryClassName = @$uploadButton.data('class-name')

  initCollectionView : () ->
    @collectionView = GalleryImageCollectionView.init @$el.find('.gallery-images-container'), @galleryClassName

  bindUpload : () ->
    @$uploadButton.fileupload
      dataType : 'json'
      url : @$uploadButton.data('url')
      formData :
        gallery : @$el.find('[type="hidden"]').val()
        class_name : @galleryClassName
      add : (e, $form) =>
        $form.submit().done @_appendUploadResult

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
    $('.gallery').each () ->
      $gallery = $(this)
      unless $gallery.data('initialized')
        Gallery.init $gallery
        $gallery.data('initialized', true)

$ ->
  $(document).on('page:load ready init-plugins', Gallery.initAll)