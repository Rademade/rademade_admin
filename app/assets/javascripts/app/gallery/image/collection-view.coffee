class @GalleryImageCollectionView extends Backbone.View

  initImages : (className) ->
    @images = new GalleryImageCollection()
    @images.setClassName(className)
    @$el.find('[data-image-id]').each (index, image) =>
      @_initImage $(image)

  initSort : () ->
    @$el.sortable() if @$el.data('sortable')

  addImage : ($image) ->
    @_initImage $image
    @$el.append $image

  _getSortedImages : () =>
    images = []
    @$el.find('[data-image-id]').each (index, el) ->
      images.push $(el).data('imageId')
    images

  _initImage : ($image) ->
    @images.add GalleryImageView.init($image)

  @init : ($el, className) ->
    collectionView = new this
      el : $el
    collectionView.initImages className
    collectionView.initSort()
    collectionView
