class @GalleryImageModel extends Backbone.Model

  remove : () ->
    $.ajax
      type : 'delete'
      url : @get 'removeUrl'
      data :
        class_name : @collection.getClassName()
      dataType : 'json'
      success : () =>
        @trigger 'image-removed'
      error : (data) =>
        window.notifier.notify data.error

  crop : (url, cropData, cb) ->
    data =
      id : @get('imageId')
      class_name : @collection.getClassName()
    data.crop = cropData
    $.ajax
      type : 'post'
      url : url
      data : data
      dataType : 'json'
      success : cb