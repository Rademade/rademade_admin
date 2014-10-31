class @Location extends Backbone.View

  initElements : () ->
    @$map = @$el.find('.map')
    @$latitude = @$el.find('[data-location-attribute="latitude"]')
    @$longitude = @$el.find('[data-location-attribute="longitude"]')
    @$zoom = @$el.find('[data-location-attribute="zoom"]')

  initMap : () ->
    @_initMap()
    @_initLayer()
    @_initMarker()

  _initMap : () ->
    @center = [@$latitude.val(), @$longitude.val()]
    @map = L.map(@$map.attr('id')).setView(@center, @$zoom.val())
    @map.on 'zoomend', (event) =>
      @$zoom.val event.target.getZoom()

  _initLayer : () ->
    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
      attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(@map)

  _initMarker : () ->
    marker = new L.marker(@center, draggable : true)
    marker.on 'dragend', (event) =>
      @_updateLatLng event.target.getLatLng()
    marker.addTo(@map)

  _updateLatLng : (latLng) ->
    @$latitude.val latLng.lat
    @$longitude.val latLng.lng

  @init : ($el) ->
    location = new this
      el : $el
    location.initElements()
    location.initMap()

  @initAll : () ->
    $('.location').each () ->
      Location.init $(this)

$ ->
  $(document).on('page:load ready init-plugins', Location.initAll)