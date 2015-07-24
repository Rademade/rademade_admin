class @Cropper extends Backbone.View

  horizontalAttributes : ['x', 'w']
  verticalAttributes : ['y', 'h']

  className : 'popup-wrapper'

  events :
    'click [data-crop]' : 'crop'
    'click [data-close]' : 'close'

  setOriginalDimensions : (originalDimensions) ->
    @originalDimensions = originalDimensions

  show : (imagePath) ->
    @render(imagePath)
    @initCrop()
    @$el.show()

  render : (imagePath) ->
    @$el.html @_getHTML(imagePath : imagePath)

  initCrop : () ->
    @$cropAttributes = @$el.find('[data-crop-attribute]')
    [originalWidth, originalHeight] = @originalDimensions
    self = this
    $image = @$el.find('.crop-image')
    $image.on 'load', () =>
      @horizontalRatio = originalWidth / $image.width()
      @verticalRatio = originalHeight / $image.height()
      $image.Jcrop
        onSelect : @_updateCropAttributes
      , () ->
        self.jcropApi = this

  crop : (e) ->
    e.preventDefault()
    @closePopup()
    @trigger 'crop-image', @_getCropData()
    false

  close : (e) ->
    e.preventDefault()
    @closePopup()

  closePopup : () ->
    @$el.hide()

  _getCropData : () ->
    cropData = {}
    @$cropAttributes.each () ->
      $cropAttribute = $(this)
      cropData[$cropAttribute.data('crop-attribute')] = $cropAttribute.val()
    cropData

  _updateCropAttributes : (attributes) =>
    @_scaleAttributes(attributes)
    @$cropAttributes.each () ->
      $cropAttribute = $(this)
      $cropAttribute.val(attributes[$cropAttribute.data('crop-attribute')])

  _scaleAttributes : (attributes) ->
    _.each @horizontalAttributes, (attribute) =>
      attributes[attribute] *= @horizontalRatio
    _.each @verticalAttributes, (attribute) =>
      attributes[attribute] *= @verticalRatio

  _getHTML : (data) ->
    JST['rademade_admin/app/templates/crop'](data)