class @Cropper extends Backbone.View

  horizontalAttributes : ['x', 'w']
  verticalAttributes : ['y', 'h']

  initCrop : () ->
    [originalWidth, originalHeight] = @model.get('crop').original_dimensions.split(',')
    self = this
    @$el.on 'load', () =>
      @horizontalRatio = (originalWidth - 0) / @$el.width()
      @verticalRatio = (originalHeight - 0) / @$el.height()
      @$el.Jcrop
        onSelect : @_updateCropAttributes
      , () ->
        self.jcropApi = this

  getCropAttributes : () ->
    @cropAttributes

  _updateCropAttributes : (attributes) =>
    @cropAttributes = @_scaleAttributes(attributes)

  _scaleAttributes : (attributes) ->
    _.each @horizontalAttributes, (attribute) =>
      attributes[attribute] *= @horizontalRatio
    _.each @verticalAttributes, (attribute) =>
      attributes[attribute] *= @verticalRatio
    attributes

  @init : ($el, model) ->
    cropper = new this
      el : $el
      model : model
    cropper.initCrop()
    cropper