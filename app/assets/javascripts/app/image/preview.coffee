class @ImagePreviewModel extends @ImageModel

  _getData : () ->
    _.extend {
      path : @get('fullUrl')
    }, super, @get('uploadParams')