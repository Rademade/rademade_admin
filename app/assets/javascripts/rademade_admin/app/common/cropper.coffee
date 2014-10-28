class @Cropper extends Backbone.View

  horizontalAttributes : ['x', 'w']
  verticalAttributes : ['y', 'h']

  className : 'add_new_popup'

  events :
    'click' : 'check'
    'click .crop-button' : 'crop'

  setOriginalDimensions : (originalDimensions) ->
    @originalDimensions = originalDimensions

  show : (imagePath) ->
    @render(imagePath)
    @initCrop()
    @$el.show()

  render : (imagePath) ->
    @$el.html @_getHTML(imagePath)

  initCrop : () ->
    @$cropAttributes = @$el.find('[data-crop-attribute]')
    [originalWidth, originalHeight] = @originalDimensions
    $image = @$el.find('.crop-image')
    $image.on 'load', () =>
      @horizontalRatio = originalWidth / $image.width()
      @verticalRatio = originalHeight / $image.height()
      $image.Jcrop
        onSelect : @_updateCropAttributes

  check : (e) ->
    @close() if $(e.target).closest('.crop').length is 0

  crop : (e) ->
    e.preventDefault()
    @close()
    @trigger 'crop-image', @_getCropData()

  close : () ->
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

  _getHTML : (imagePath) ->
    """
      <div class="crop">
        <img class="crop-image" src="#{imagePath}">
        <button class="crop-button">Crop</button>
        <input type="hidden" data-crop-attribute="x"/>
        <input type="hidden" data-crop-attribute="y"/>
        <input type="hidden" data-crop-attribute="w"/>
        <input type="hidden" data-crop-attribute="h"/>
      </div>
    """