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
        onChange : @_showAttributes
      , () ->
        self.jcropApi = this
        self.$jcropSize = $('<div style="left: 100%; position: relative; display: none" data-jcrop-size></div>')
        self.$el.siblings('.jcrop-holder').children('div:first').append(self.$jcropSize)

  getCropAttributes : () ->
    @cropAttributes

  _updateCropAttributes : (attributes) =>
    @cropAttributes = @_scaleAttributes(attributes)

  _showAttributes : (attributes) =>
    @$jcropSize.show()
    @$jcropSize.html @_attributesHTML(attributes)

  _attributesHTML : (attributes) ->
    """
      <div>#{attributes.w}</div>
      <div>#{attributes.h}</div>
    """

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