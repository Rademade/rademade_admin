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
    @$menu.find('.with-dd').click (e) =>
      $clickedMenuItem = $(e.currentTarget)
      href = $clickedMenuItem.attr('href')
      if href is ''
        e.preventDefault()
        @_toggleGroupMenuItem $clickedMenuItem
      else if href is window.location.pathname
        e.preventDefault()
        @_toggleMenuItem $clickedMenuItem

  _toggleGroupMenuItem : ($menuItem) ->
    $activeMenuItem = @$menu.find('>> .is-active')
    @_toggleMenuItem($activeMenuItem) unless $menuItem.is $activeMenuItem
    @_toggleMenuItem $menuItem

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