class @GalleryImageCollectionView extends Backbone.View

  _views : []

  setClassName : (className) ->
    @className = className

  initImages : () ->
    @$el.find('.gallery-image').each (index, image) =>
      @_initImage $(image)

  initSort : () ->
    sortUrl = @$el.data('sortable-url')
    if sortUrl
      @$el.sortable
        stop : () =>
          @_sort sortUrl

  addImage : ($image) ->
    @_initImage $image
    @$el.append $image

  _sort : (sortUrl) =>
    $.ajax
      type : 'patch'
      url : sortUrl
      data :
        class_name : @className
        images : @_getSortedImages()
      dataType : 'json'

  _getSortedImages : () =>
    images = []
    @$el.find('.gallery-image').each (index, el) ->
      images.push $(el).data('id')
    images

  _initImage : ($image) ->
    view = new GalleryImageView
      el : $image
    view.setClassName @className
    @_views.push view

  @init : ($el, className) ->
    collectionView = new this
      el : $el
    collectionView.setClassName className
    collectionView.initImages()
    collectionView.initSort()
    collectionView