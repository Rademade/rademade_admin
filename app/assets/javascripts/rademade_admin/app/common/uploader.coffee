class @Uploader extends Backbone.View

  events :
    'click [data-upload]' : 'upload'
    'click [data-crop]' : 'crop'

  initialize : (options) ->
    super
    @$uploader = options.$uploader
    @$progressWrapper = @$el.find('.upload-progress-wrapper')

  initFileUpload : () ->
    @$uploader.fileupload
      dataType : 'json'
      url : @$uploader.data('url')
      formData : @_getUploaderData()
      add : @submitFile
      done : => @$progressWrapper.hide()
      error : => @$progressWrapper.hide()
      progressall : @updateUploadProggress

  initJcrop : () ->
    @$cropButton = @$el.find('[data-crop]')
    if @$cropButton.length > 0
      @$cropAttributes = @$el.find('[data-crop-attribute]')
      @$el.find('img').Jcrop
        onSelect : @updateCropAttributes

  upload : () ->
    @$el.find('input.uploader-input-file').click()

  crop : () ->
    $.ajax
      type : 'post'
      url : @$cropButton.data('url')
      data : @_getAllData()
      dataType : 'json'
      success : (data) =>
        console.log data

  submitFile : (e, $form) =>
    @_setUploadProgress(0)
    @$progressWrapper.show()
    $form.submit().done @_appendUploadResult

  updateUploadProggress : (e, data) =>
    progress = parseInt(data.loaded / data.total * 100, 10)
    @_setUploadProgress(progress)

  updateCropAttributes : (attributes) =>
    @$cropAttributes.each () ->
      $cropAttribute = $(this)
      $cropAttribute.val(attributes[$cropAttribute.data('crop-attribute')])

  _getUploaderData : () ->
    _.pick(@$uploader.data(), 'id', 'saved', 'model', 'column', 'uploader')

  _getCropData : () ->
    cropData = {}
    @$cropAttributes.each () ->
      $cropAttribute = $(this)
      cropData[$cropAttribute.data('crop-attribute')] = $cropAttribute.val()
    cropData

  _getAllData : () ->
    allData = @_getUploaderData()
    allData.crop = @_getCropData()
    allData

  _setUploadProgress : (progress) =>
    @$el.find('.upload-progress').width(progress + '%')

  _appendUploadResult : (result) =>
    @$el
      .find('.preview-wrapper').replaceWith(result.html).end()
      .find('input[type="hidden"]').val(result.file[@$uploader.data('column')].url)


Uploader.init = ($uploader) ->
  uploader = new Uploader
    el : $uploader.closest('.uploader-wrapper')
    $uploader : $uploader
  uploader.initFileUpload()
  uploader.initJcrop()
  uploader

Uploader.initAll = () ->
  $('.uploader-input-file').each (index, el) ->
    Uploader.init $(el)

$ ->
  $(document).on('page:load ready init-uploader', Uploader.initAll)