initUploader = ->

  window.bindFileUploader = ($el, $wrapper) ->
    @$el = $el
    @$wrapper = $wrapper
    this

  bindFileUploader::submitFile = (e, $form) ->
    @_setUploadProgress(0)
    @_showUploader()
    $form.submit().done =>
      @_appendUploadResult.apply(this, arguments)

  bindFileUploader::uploadDone = () ->
    @_hideUploader()

  bindFileUploader::uploadError = () ->
    @_hideUploader()

  bindFileUploader::updateUploadProggress = (e, data) ->
    progress = parseInt(data.loaded / data.total * 100, 10)
    @_setUploadProgress(progress)

  bindFileUploader::_showUploader = ->
    @$wrapper.find('.upload-progress-wrapper').show()

  bindFileUploader::_hideUploader = ->
    @$wrapper.find('.upload-progress-wrapper').hide()

  bindFileUploader::_setUploadProgress = (progress) ->
    @$wrapper.find('.upload-progress').width(progress + '%')

  bindFileUploader::_appendUploadResult = (result)->
    @$wrapper.find('.preview-wrapper').replaceWith(result.html)
    @$wrapper.find('input[type="hidden"]').val(result.file[@$el.data('column')].url)

  bindFileUploader::init = () ->
    #todo url take from dom
    @$el.fileupload
      dataType : 'json'
      url : @$el.data('url')
      formData : _.pick(@$el.data(), 'id', 'saved', 'model', 'column', 'uploader')
      add : => @submitFile.apply(this, arguments)
      done : => @uploadDone.apply(this, arguments)
      error : => @uploadError.apply(this, arguments)
      progressall : => @updateUploadProggress.apply(this, arguments)

  $('.uploader-input-file').each (index, el) ->
    $el = $(el)
    (new bindFileUploader($el, $el.closest('.uploader-wrapper'))).init()

$ ->
  $(document).on('page:load ready init-uploader', initUploader)
