class @ImageModel extends Backbone.Model

  crop : (cropAttributes) ->
    $.ajax
      type : 'post'
      url : @get('crop').url
      data : @_getData(cropAttributes)
      dataType : 'json'
      success : @_onSuccess

  _getData : (cropAttributes) ->
    id : @get('imageId')
    crop : cropAttributes

  _onSuccess : (result) =>
    @set
      fullUrl : result.image_data.full_url
      crop : result.image_data.crop
      resizedUrl : result.resized_url
    @trigger 'crop'