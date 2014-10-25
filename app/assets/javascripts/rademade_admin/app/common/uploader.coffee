class @Uploader extends Backbone.View

  horizontalAttributes : ['x', 'w']
  verticalAttributes : ['y', 'h']

  events :
    'click [data-upload]' : 'upload'
    'click [data-crop]' : 'crop'

  initialize : (options) ->
    super
    @$uploader = options.$uploader

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

  initJcrop : () ->
    if @$cropButton.length > 0
      $image = @$el.find('img')
      [originalWidth, originalHeight] = $image.data('original-dimensions').split(',')
      @horizontalRatio = originalWidth / $image.width()
      @verticalRatio = originalHeight / $image.height()
      $image.Jcrop
        onSelect : @updateCropAttributes

  upload : () ->
    @$el.find('input.uploader-input-file').click()

  crop : () ->
    $.ajax
      type : 'post'
      url : @$cropButton.data('url')
      data : @_getAllData()
      dataType : 'json'
      success : @onSuccess

  submitFile : (e, $form) =>
    @_setUploadProgress(0)
    @$progressWrapper.show()
    $form.submit().done @onSuccess

  updateUploadProggress : (e, data) =>
    progress = parseInt(data.loaded / data.total * 100, 10)
    @_setUploadProgress(progress)

  updateCropAttributes : (attributes) =>
    @_scaleAttributes(attributes)
    @$cropAttributes.each () ->
      $cropAttribute = $(this)
      $cropAttribute.val(attributes[$cropAttribute.data('crop-attribute')])

  onSuccess : (result) =>
    @_appendUploadResult(result)
    @initJcrop()

  _scaleAttributes : (attributes) ->
    _.each @horizontalAttributes, (attribute) =>
      attributes[attribute] *= @horizontalRatio
    _.each @verticalAttributes, (attribute) =>
      attributes[attribute] *= @verticalRatio

  _getUploaderData : () ->
    uploaderData = _.pick(@$uploader.data(), 'id', 'saved', 'model', 'column', 'uploader')
    uploaderData.path = @$el.find('.form-input[type="hidden"]').val()
    uploaderData

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
      .find('.form-input[type="hidden"]').val(result.file[@$uploader.data('column')].url)


Uploader.init = ($uploader) ->
  uploader = new Uploader
    el : $uploader.closest('.uploader-wrapper')
    $uploader : $uploader
  uploader.initElements()
  uploader.initFileUpload()
  uploader.initJcrop()
  uploader

Uploader.initAll = () ->
  $('.uploader-input-file').each (index, el) ->
    Uploader.init $(el)

$ ->
  $(document).on('page:load ready init-uploader', Uploader.initAll)