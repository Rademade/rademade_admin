class @Cropper extends Backbone.View

  horizontalAttributes : ['x', 'w']
  verticalAttributes : ['y', 'h']

  initCrop : () ->
    self = this
    @$el.on 'load', () =>
      @_onLoad () ->
        self.jcropApi = this
        self.$jcropSize = $ self._jcropSizeHTML()
        self.$el.siblings('.jcrop-holder').find('> :first > :first').after(self.$jcropSize)

  getCropAttributes : () ->
    @cropAttributes

  _onLoad : (onInitializeCb) =>
    [originalWidth, originalHeight] = @model.get('crop').original_dimensions.split(',')
    @horizontalRatio = (originalWidth - 0) / @$el.width()
    @verticalRatio = (originalHeight - 0) / @$el.height()
    @$el.Jcrop
      onSelect : @_updateCropAttributes
      onChange : @_showAttributes
    , onInitializeCb

  _updateCropAttributes : (attributes) =>
    @cropAttributes = @_scaleAttributes(attributes)

  _showAttributes : (attributes) =>
    @$jcropSize.show()
    @$jcropSize.html @_attributesHTML(attributes)

  _jcropSizeHTML : () ->
    JST['app/templates/crop/size']()

  _attributesHTML : (attributes) ->
    JST['app/templates/crop/attributes']
      width : attributes.w
      height : attributes.h

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