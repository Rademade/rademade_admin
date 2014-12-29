class @GalleryImageModel extends Backbone.Model

  defaults :
    imageId : 0
    className : ''
    removeUrl : ''

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