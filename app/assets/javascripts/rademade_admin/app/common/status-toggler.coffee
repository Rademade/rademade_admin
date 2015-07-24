class @StatusToggler

  bindToggle : () ->
    $('[data-toggle-url]').click (e) =>
      $element = $(e.currentTarget)
      @_toggleClass $element
      @_toggleStatus $element.data('toggleUrl')

  _toggleStatus : (statusUrl) ->
    unless @sending
      @sending = true
      $.ajax
        type : 'post'
        url : statusUrl
        dataType : 'json'
        success : (data) =>
          notifier.notify data.message
      .always () =>
        @sending = false

  _toggleClass : ($element) ->
    if $element.hasClass('visibility')
      removeClass = 'visibility'
      addClass = 'invisibility'
    else
      removeClass = 'invisibility'
      addClass = 'visibility'
    $element.removeClass(removeClass).addClass(addClass)

  @init : () ->
    statusToggler = new this
    statusToggler.bindToggle()
    statusToggler

  @initPlugin : () =>
    @init()

$ ->
  $(document).on 'ready page:load init-plugins', StatusToggler.initPlugin