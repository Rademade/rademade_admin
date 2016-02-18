class @Uploader extends Backbone.View

  events :
    'click .upload-delete' : 'removeFile'

  initElements : () ->
    @$uploader = @$el.find('[data-uploader]')
    @$hidden = @$el.find('input[type="hidden"]')
    @$loaderHolder = @$el.find('.upload-item.add')
    @uploaderText = @$loaderHolder.find('.upload-text').text()

  initFileUpload : () ->
    @$uploader.fileupload
      dataType : 'json'
      dropZone : @$el
      url : @$uploader.data('url')
      formData : @_getUploaderData()
      add : (e, $form) =>
        @showLoader()
        $form.submit().done @updateUploader
      always : @hideLoader

  updateUploader : (result) =>
    @$el.find('[data-preview-item]').replaceWith(result.html)
    @$el.find('.upload-holder.hide').removeClass('hide')
    @$hidden.val(result.file[@$uploader.data('column')].url)
    ImagePreview.initPlugin()

  showLoader : () ->
    @$loaderHolder.addClass('is-loading')
    @$loaderHolder.find('.upload-text').text I18n.t('rademade_admin.uploader.add.processing')

  hideLoader : () =>
    @$loaderHolder.removeClass('is-loading')
    @$loaderHolder.find('.upload-text').text @uploaderText

  removeFile : () ->
    @$el.find('.upload-holder:has([data-preview-item])').fadeOut 300, () ->
      $(this).addClass('hide').show()
    @$hidden.val('')

  _getUploaderData : () ->
    uploaderData = _.pick @$uploader.data(), 'id', 'model', 'column', 'uploader'
    uploaderData.path = @$hidden.val()
    uploaderData.authenticity_token = encodeURI $('meta[name="csrf-token"]').attr('content')
    uploaderData

  @init : ($uploader) ->
    uploader = new this
      el : $uploader
    uploader.initElements()
    uploader.initFileUpload()
    uploader

  @initAll : () ->
    $('[data-upload]').each (index, el) =>
      $uploader = $(el)
      unless $uploader.data('initialized')
        @init $uploader
        $uploader.data('initialized', true)

  @initPlugin : () =>
    @initAll()

$ ->
  $(document).on 'page:load ready init-plugins', Uploader.initPlugin