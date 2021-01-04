class @Content extends Backbone.View

  isLoadingContentItem = false

  renderItemFromUrl : (url, cb, urlData = {}) ->
    return if isLoadingContentItem
    return if url == ''
    $(document).trigger 'before-content-render'
    @_updateHistory(url)
    $('#loader').removeClass('hide')
    isLoadingContentItem = true
    $.get url, _.extend(urlData, layout : false), (html) =>
      $contentItem = $(html)
      $('[data-content]').append $contentItem
      $(window).scrollTop(0)
      $(document).trigger 'init-plugins'
      @bindClick $contentItem
      cb($contentItem) if cb
      isLoadingContentItem = false
      $('#loader').addClass('hide')

  renderModel : (model, urlData = {}) ->
    @renderItemFromUrl model.get('editurl'), ($contentItem) =>
      $contentItem.find('form').on 'ajax-submit-done', (e, response) =>
        model.update response.data
        $contentItem.remove()
    , urlData

  moveToPreviousContentItem : () ->
    @moveToContentItem $('[data-content-item]:nth-last-child(2)')

  moveToContentItem : ($contentItem) ->
    if $contentItem.length is 0
      window.history.back() if window.history.length > 2
    else
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
      $contentItem = $(e.currentTarget).closest('[data-content-item]')
      $prevContentItem = $contentItem.prev()
      if $prevContentItem.length is 0
        @moveToContentItem $contentItem
      else
        @moveToContentItem $prevContentItem

  bindDocumentClick : () =>
    @bindClick($(document))

  bindHistoryBack : () ->
    $(window).bind 'popstate', (e) ->
      state = e.originalEvent.state
      window.location.href = state.url if state.url

  _updateHistory : (url) ->
    if history.pushState isnt undefined and $('[data-content-header]').length < 2
      history.pushState url : url, document.title, url

  @init : () ->
    content = new this()
    content.bindHistoryBack()
    content.bindDocumentClick()
    content

  @initInstance : () =>
    window.ContentInstance = @init()

  @getInstance : () ->
    window.ContentInstance

  $ ->
    $(document).on 'page:load ready', Content.initInstance
