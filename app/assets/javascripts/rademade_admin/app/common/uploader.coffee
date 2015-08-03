class @Uploader extends Backbone.View

  initElements : () ->
    @$uploader = @$el.find('[data-uploader]')
    @$hidden = @$el.find('input[type="hidden"]')

  initFileUpload : () ->
    @$uploader.fileupload
      dataType : 'json'
      url : @$uploader.data('url')
      formData : @_getUploaderData()
      add : @submitFile

  submitFile : (e, $form) =>
    $form.submit().done @updateUploader

  updateUploader : (result) =>
    @$el.find('.preview-wrapper').replaceWith(result.html)
    @$hidden.val(result.file[@$uploader.data('column')].url)

  _getUploaderData : () ->
    uploaderData = _.pick(@$uploader.data(), 'id', 'saved', 'model', 'column', 'uploader')
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