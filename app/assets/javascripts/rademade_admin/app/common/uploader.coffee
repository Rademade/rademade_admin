initUploader = ->

  console.log('Initing uploader...')

  window.bindFileUploader = ($el, $wrapper)->
    @$el = $el
    @$wrapper = $wrapper
    @

  bindFileUploader::submitFile = (e, $form)->
    @_setUploadProgress( 0 )
    @_showUploader()
    $form.submit().done( => @_appendUploadResult.apply(@, arguments) )

  bindFileUploader::uploadDone = ->
    @_hideUploader()
    console.log('Upload done!', arguments)

  bindFileUploader::uploadError = ->
    @_hideUploader()
    console.log('Upload error', arguments)

  bindFileUploader::updateUploadProggress = (data) ->
    progress = parseInt(data.loaded / data.total * 100, 10)
    @_setUploadProgress( progress )

  bindFileUploader::_showUploader = ->
    @$wrapper.find('.upload-progress-wrapper').show()

  bindFileUploader::_hideUploader = ->
    @$wrapper.find('.upload-progress-wrapper').hide()

  bindFileUploader::_setUploadProgress = (progress) ->
    @$wrapper.find('.upload-progress').width( progress + '%' )

  bindFileUploader::_appendUploadResult = (result)->
    @$wrapper.find('.image-preview-wrapper').replaceWith( result.html )
    @$wrapper.find('.hidden').val( result.file[@$el.data('column')].url )

  bindFileUploader::init = ->
    @$el.fileupload
      dataType: "json"
      url: '/rademade_admin/file-upload'
      formData: _.pick( @$el.data(), 'id', 'saved', 'model', 'column', 'uploader' )
      add: => @submitFile.apply(@, arguments)
      done: => @uploadDone.apply(@, arguments)
      error: => @uploadError.apply(@, arguments)
      progressall: => @updateUploadProggress.apply(@, arguments)

  $(".uploader-input-file").each (index, el) ->
    $el = $(el)
    ( new bindFileUploader( $el, $el.closest('.uploader-wrapper') ) ).init( )

$ ->
  $(document).on('page:load ready init-uploader', initUploader)
