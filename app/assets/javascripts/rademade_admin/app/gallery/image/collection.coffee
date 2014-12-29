class @GalleryImageCollection extends Backbone.Collection

  setClassName : (className) ->
    @className = className

  getClassName : () ->
    @className

  setSortUrl : (sortUrl) ->
    @sortUrl = sortUrl

  sort : (images) ->
    $.ajax
      type : 'patch'
      url : @sortUrl
      data :
        class_name : @className
        images : images
      dataType : 'json'