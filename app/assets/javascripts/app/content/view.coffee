class @Content extends Backbone.View

  renderItemFromUrl : (url, cb) ->
    $(document).trigger 'before-content-render'
    @_updateHistory(url)
    $.get url, layout : false, (html) =>
      $contentItem = $(html)
      $('[data-content]').append $contentItem
      $(window).scrollTop(0)
      $(document).trigger 'init-plugins'
      @bindClick $contentItem
      cb($contentItem) if cb

  renderModel : (model) ->
    @renderItemFromUrl model.get('editurl'), ($contentItem) =>
      $contentItem.find('form').on 'ajax-submit-done', (e, response) =>
        model.update response.data
        $contentItem.remove()

  moveToPreviousContentItem : () ->
    @moveToContentItem $('[data-content-item]:nth-last-child(2)')

  moveToContentItem : ($contentItem) ->
    return if $contentItem.is(':last-child')
    $contentItem.nextAll('[data-content-item]').remove()
    if $contentItem.is(':first-child')
      @renderItemFromUrl $contentItem.data('contentItem'), () ->
        $contentItem.remove()

  bindClick : ($el) ->
    $el.find('[data-content-header]').bind 'click', (e) =>
      @moveToContentItem $(e.currentTarget).closest('[data-content-item]')
    $el.find('[data-content-url]').one 'click', (e) =>
      @renderItemFromUrl $(e.currentTarget).data('contentUrl')
      false
    $el.find('[data-content-close]').bind 'click', (e) =>
      @moveToContentItem $(e.currentTarget).closest('[data-content-item]').prev()

  bindHistoryBack : () ->
    $(window).bind 'popstate', (e) ->
      state = e.originalEvent.state
      window.location.href = state.url if state.url

  _updateHistory : (url) ->
    if history.pushState isnt undefined and $('[data-content-header]').length < 2
      history.pushState url : url, document.title, url

  @init : () ->
    content = new Content()
    content.bindHistoryBack()
    content

  @getInstance : () ->
    instance = null
    do () ->
      instance ||= Content.init()

$ ->
  $(document).on 'page:load ready', () ->
    Content.getInstance().bindClick $(document)
