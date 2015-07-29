instance = null

class @Content extends Backbone.View

  renderItemFromUrl : (url) ->
    console.log url

  @init : () ->
    instance = new Content
      el : $('[data-content]')

  @getInstance : () ->
    instance

$ ->
  $(document).on('page:load ready', Content.init)