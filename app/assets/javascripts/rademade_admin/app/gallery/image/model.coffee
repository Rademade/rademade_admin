class @GalleryImageModel extends ImageModel

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

  _getData : () ->
    data = super
    data.class_name = @collection.getClassName()
    data