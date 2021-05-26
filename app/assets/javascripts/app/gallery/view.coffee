class @Gallery extends Backbone.View

  initUploadButton : () ->
    @$uploadButton = @$el.find('[type="file"]')
    @galleryClassName = @$uploadButton.data('class-name')
    @$loaderHolder = @$el.find('.upload-item.add')

  initCollectionView : () ->
    @collectionView = GalleryImageCollectionView.init @$el.find('.upload-box'), @galleryClassName

  # todo refactor
  bindUpload : () ->
    @$uploadButton.fileupload
      dataType : 'json'
      dropZone : @$el
      add : (e, data) =>
        @showLoader()
        filesLeft = data.files.length
        $.each data.files, (index, file) =>
          reader = new FileReader()
          reader.readAsDataURL(file)
          reader.onload = () =>
            # todo move template to view render
            image = reader.result
            imageHtml = "<div class='upload-holder ui-sortable-handle' data-full-url='#{image}'>
              <div class='upload-item'>
                <img src='#{image}'>
                <i class='upload-delete' data-remove=''></i>
              </div>
            </div>"
            @collectionView.addImage $(imageHtml)
            filesLeft--
            @hideLoader() if filesLeft <= 0
      stop : @hideLoader
      error : (data) =>
        if data.responseJSON?.error
          window.notifier.notify data.responseJSON.error

  showLoader : () ->
    @$loaderHolder.addClass('is-loading')

  hideLoader : () =>
    @$loaderHolder.removeClass('is-loading')

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
