class @Uploader extends Backbone.View

  events :
    'click [data-upload]' : 'upload'
    'click [data-crop]' : 'crop'

  initialize : (options) ->
    super
    @$uploader = options.$uploader
    @_initCropper()

  initElements : () ->
    @$progressWrapper = @$el.find('.upload-progress-wrapper')
    @$cropButton = @$el.find('[data-crop]')
    @$cropAttributes = @$el.find('[data-crop-attribute]')

  initFileUpload : () ->
    @$uploader.fileupload
      dataType : 'json'
      url : @$uploader.data('url')
      formData : @_getUploaderData()
      add : @submitFile
      done : => @$progressWrapper.hide()
      error : => @$progressWrapper.hide()
      progressall : @updateUploadProggress

  upload : () ->
    @$el.find('input.uploader-input-file').click()

  crop : () ->
    imagePath = @$el.find('.form-input[type="hidden"]').val()
    if imagePath
      @cropper.setOriginalDimensions @$el.find('img').data('original-dimensions').split(',')
      @cropper.show imagePath
      @$el.append(@cropper.$el)

  submitFile : (e, $form) =>
    @_setUploadProgress(0)
    @$progressWrapper.show()
    $form.submit().done @appendUploadResult

  updateUploadProggress : (e, data) =>
    progress = parseInt(data.loaded / data.total * 100, 10)
    @_setUploadProgress(progress)

  appendUploadResult : (result) =>
    @$el
      .find('.preview-wrapper').replaceWith(result.html).end()
      .find('.form-input[type="hidden"]').val(result.file[@$uploader.data('column')].url)

  _initCropper : () ->
    @cropper = new Cropper()
    @cropper.on 'crop-image', @_crop

  _crop : (cropData) =>
    allData = @_getUploaderData()
    allData.crop = cropData
    $.ajax
      type : 'post'
      url : @$cropButton.data('url')
      data : allData
      dataType : 'json'
      success : @appendUploadResult

  _getUploaderData : () ->
    uploaderData = _.pick(@$uploader.data(), 'id', 'saved', 'model', 'column', 'uploader')
    uploaderData.path = @$el.find('.form-input[type="hidden"]').val()
    uploaderData.authenticity_token = encodeURI($('meta[name="csrf-token"]').attr('content'))
    uploaderData

  _setUploadProgress : (progress) =>
    @$el.find('.upload-progress').width(progress + '%')

  @init : ($uploader) ->
    uploader = new this
      el : $uploader.closest('.uploader-wrapper')
      $uploader : $uploader
    uploader.initElements()
    uploader.initFileUpload()
    uploader

  @initAll : () ->
    $('.uploader-input-file').each (index, el) =>
      $uploader = $(el)
      unless $uploader.data('initialized')
        @init $uploader
        $uploader.data('initialized', true)

  @initPlugin : () =>
    @initAll()

$ ->
  $(document).on 'page:load ready init-plugins', Uploader.initPlugin