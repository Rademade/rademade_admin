instance = null

class @Content extends Backbone.View

  renderItemFromUrl : (url) ->
    $.get url, () ->
      console.log arguments

  bindUrlClick : () ->
    $('[data-content-url]').click (e) =>
      @renderItemFromUrl $(e.currentTarget).data('contentUrl')

  @init : () ->
    new Content
      el : $('[data-content]')

  @getInstance : () ->
    do () ->
      instance ||= Content.init()

$ ->
  $(document).on('page:load ready', Content.init)
  $(document).on 'page:load ready init-plugins', () ->
    Content.getInstance().bindUrlClick()