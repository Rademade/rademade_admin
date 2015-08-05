class @GalleryImageModel extends Backbone.Model

  remove : () ->
    $.ajax
      type : 'delete'
      url : @get 'removeUrl'
      data :
        class_name : @collection.getClassName()
      dataType : 'json'
      success : () =>
        @collection.remove this
        @trigger 'image-removed'
      error : (data) =>
        window.notifier.notify data.error

  crop : (cropAttributes, cb) ->
    data =
      id : @get('imageId')
      crop : cropAttributes
      class_name : @collection.getClassName()
    $.ajax
      type : 'post'
      url : @get('crop').url
      data : data
      dataType : 'json'
      success : (result) =>
        @set
          fullUrl : result.image_data.full_url
          crop : result.image_data.crop
          resizedUrl : result.resized_url
        cb()