class @ListEdit extends Backbone.View

  events :
    'click [data-list-edit]' : 'toggle'
    'click [data-list-cancel]' : 'toggle'

  initElements : () ->
    @$listElements = @$el.find('[data-list-value], [data-list-form]')
    @$displayValue = @$el.find('[data-list-display-value]')

  bindSubmit : () ->
    @$el.find('form').on 'ajax-submit-done', (e, response) =>
      @$displayValue.html(response.display_value)
      @toggle()

  toggle : () ->
    @$listElements.toggleClass('hide')
    false

  @init : ($el) ->
    listEdit = new this
      el : $el
    listEdit.initElements()
    listEdit.bindSubmit()

  @initAll : () ->
    $('.table-item:has([data-list-edit])').each (index, el) =>
      $tableItem = $(el)
      unless $tableItem.data('initialized')
        @init $tableItem
        $tableItem.data('initialized', true)

  @initPlugin : () =>
    @initAll()

$ ->
  $(document).on 'ready page:load', ListEdit.initPlugin