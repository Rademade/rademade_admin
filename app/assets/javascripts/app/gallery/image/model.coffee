class @GalleryImageModel extends ImageModel

  remove : () ->
    @collection.remove this
    @trigger 'image-removed'

  _getData : () ->
    data = super
    data.class_name = @collection.getClassName()
    data
