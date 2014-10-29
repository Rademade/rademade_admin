class @Cropper extends Backbone.View

  horizontalAttributes : ['x', 'w']
  verticalAttributes : ['y', 'h']

  className : 'add_new_popup'

  events :
    'click' : 'check'
    'click [data-crop]' : 'crop'
    'click [data-close]' : 'close'

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
    @closePopup() if $(e.target).closest('.crop').length is 0

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

  _getHTML : (imagePath) ->
    """
      <div class="crop">
        <img class="crop-image" src="#{imagePath}">
        <div class="crop-actions">
          <button class="btn blue-btn" data-crop>Crop</button>
          <button class="btn red-btn" data-close>Discard</button>
        </div>
        <input type="hidden" data-crop-attribute="x"/>
        <input type="hidden" data-crop-attribute="y"/>
        <input type="hidden" data-crop-attribute="w"/>
        <input type="hidden" data-crop-attribute="h"/>
      </div>
    """