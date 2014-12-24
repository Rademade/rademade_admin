# todo sort
class @GalleryImageCollectionView extends Backbone.View

  _views : []

  setClassName : (className) ->
    @className = className

  initImages : () ->
    @$el.find('.gallery-image').each (index, image) =>
      @_initImage $(image)

  addImage : ($image) ->
    @_initImage $image
    @$el.append $image

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
    collectionView