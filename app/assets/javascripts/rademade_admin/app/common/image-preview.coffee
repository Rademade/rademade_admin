class @ImagePreview extends Backbone.View

  className : 'add_new_popup hide'

  events :
    'click' : 'close'

  show : (imagePath) ->
    @render(imagePath)
    @$el.removeClass 'hide'

  close : (e) ->
    e.preventDefault()
    @closePopup()

  closePopup : () ->
    @$el.addClass 'hide'

  render : (imagePath) ->
    @$el.html @_getHTML(imagePath : imagePath)

  _getHTML : (data) ->
    JST['rademade_admin/app/templates/image-preview-popup'](data)

  @init : () ->
    imagePreview = new this
    $('#pad-wrapper').append imagePreview.$el
    $('tr .image-preview').click (e) ->
      fullUrl = $(e.currentTarget).attr('full-url')
      imagePreview.show(fullUrl) if fullUrl

  @initPlugin : () =>
    @init()

$ ->
  $(document).on 'page:load ready init-plugins', ImagePreview.initPlugin