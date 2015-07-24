class @GalleryPopup extends Backbone.View

  className : 'popup-wrapper'

  events :
    'click [data-close]' : 'close'

  show : () ->
    @render()
#    @initCrop()
    @$el.show()

  render : (imagePath) ->
    @$el.append @_getHTML()

  onCrop : (cb) ->
#    @cropper.on 'crop-image', cb

  close : (e) ->
    e.preventDefault()
    @closePopup()

  closePopup : () ->
    @$el.hide()

  _getHTML : (data) ->
    JST['rademade_admin/app/templates/gallery-popup'](data)


  @getInstance : () ->
    instance = null
    do () ->
      instance ||= new @GalleryPopup
        el : document.querySelector 'body'