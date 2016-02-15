class @Menu

  initElements : () ->
    @$menu = $('.nav-list.with-scroll')

  bindScroll : () ->
    return unless localStorage
    @$menu.scrollTop localStorage.getItem('scrollTop') - 0
    $(document).on 'page:before-unload', () =>
      localStorage.setItem 'scrollTop', @$menu.scrollTop()

  bindToggle : () ->
    $('#menuToggler').on 'click', () ->
      $('#wrapper').toggleClass('opened-menu')

  bindModelLessLinks : () ->
    @$menu.find('.with-dd[href=""]').click (e) =>
      e.preventDefault()
      @_toggleMenuItem @$menu.find('>> .is-active')
      @_toggleMenuItem $(e.currentTarget)

  _toggleMenuItem : ($menuItem) ->
    return unless $menuItem
    $menuItem
      .toggleClass('is-active')
      .siblings('.nav-dd').toggleClass('hide')

  @init : () =>
    menu = new this
    menu.initElements()
    menu.bindScroll()
    menu.bindToggle()
    menu.bindModelLessLinks()
    menu

$ ->
  $(document).on 'ready page:load', Menu.init