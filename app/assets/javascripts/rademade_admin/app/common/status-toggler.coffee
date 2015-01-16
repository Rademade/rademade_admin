class @StatusToggler

  bindToggle : () ->
    $('[data-toggle-url]').click (e) =>
      @_toggleStatus $(e.currentTarget)

  _toggleStatus : ($button) ->
    unless @sending
      @sending = true
      $.ajax
        type : 'post'
        url : $button.data('toggleUrl')
        dataType : 'json'
        success : (data) =>
          notifier.notify data.message
      .always () =>
        @sending = false

  @init : () ->
    statusToggler = new StatusToggler
    statusToggler.bindToggle()
    statusToggler

$ ->
  $(document).on 'ready page:load init-plugins', StatusToggler.init