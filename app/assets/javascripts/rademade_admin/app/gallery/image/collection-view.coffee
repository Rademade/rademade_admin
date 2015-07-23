class @GalleryImageCollectionView extends Backbone.View

  initImages : (className) ->
    @images = new GalleryImageCollection()
    @images.setClassName(className)
    @$el.find('[data-id]').each (index, image) =>
      @_initImage $(image)

  initSort : () ->
    sortUrl = @$el.data('sortable-url')
    if sortUrl
      @images.setSortUrl sortUrl
      @$el.sortable
        stop : () =>
          @images.sort @_getSortedImages()

  addImage : ($image) ->
    @_initImage $image
    @$el.append $image

  _getSortedImages : () =>
    images = []
    @$el.find('[data-id]').each (index, el) ->
      images.push $(el).data('id')
    images

  _initImage : ($image) ->
    @images.add GalleryImageView.init($image)

  @init : ($el, className) ->
    collectionView = new this
      el : $el
    collectionView.initImages className
    collectionView.initSort()
    collectionView