class @FormPopup.Collection extends Backbone.Collection

  lastModel : undefined

  initialize : () ->
    @on 'add', @showModel
    @on 'remove', @onModelRemove

  getModelWithClass : (modelClassName) ->
    @findWhere
      modelClassName : modelClassName

  showModel : (model) =>
    @lastModel.trigger('hide') if @lastModel
    @lastModel = model
    model.trigger 'show'

  onModelRemove : () =>
    @lastModel = @last()
    @lastModel.trigger('show') if @lastModel