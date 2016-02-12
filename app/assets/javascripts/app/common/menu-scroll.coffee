class @MenuScroll

  bindScroll : () ->
    return unless localStorage
    $menu = $('.nav-list.with-scroll')
    $menu.scrollTop localStorage.getItem('scrollTop') - 0
    $(document).on 'page:before-unload', () ->
      localStorage.setItem 'scrollTop', $menu.scrollTop()

  @init : () ->
    menuScroll = new this
    menuScroll.bindScroll()
    menuScroll

  @initPlugin : () =>
    @init()

$ ->
  $(document).on 'ready page:load init-plugins', MenuScroll.initPlugin