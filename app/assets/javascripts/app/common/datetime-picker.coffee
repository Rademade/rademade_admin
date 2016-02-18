class @CalendarPicker

  initElements : ($calendarPicker) ->
    @$calendarPicker = $calendarPicker
    @isDateTimePicker = $calendarPicker.data('calendarPicker') is 'datetime'
    @$calendarHolder = $calendarPicker.parent()
    @$calendarPicker.filthypillow()

  bindCalendarListeners : () ->
    @$calendarPicker.on 'focus', () =>
      @$calendarPicker.filthypillow 'show'

    @$calendarPicker.on 'fp:save', (e, dateObj) =>
      @$calendarPicker.val dateObj.format(@_getFormat())
      @$calendarPicker.filthypillow 'hide'

  bindHolderListeners : () ->
    @$calendarHolder.on 'fp:show', (event) =>
      event.stopPropagation()
      @$calendarHolder.addClass('is-active')

    @$calendarHolder.on 'fp:hide', (event) =>
      event.stopPropagation()
      @$calendarHolder.removeClass('is-active')

  _getFormat : () ->
    format = 'DD.MM.YYYY'
    format += ' HH:mm' if @isDateTimePicker
    format
      
  @init : ($calendarPicker) ->
    calendarPicker = new this
    calendarPicker.initElements($calendarPicker)
    calendarPicker.bindCalendarListeners()
    calendarPicker.bindHolderListeners()
    calendarPicker

  @initAll : () ->
    $('[data-calendar-picker]').each (index, el) =>
      $calendarPicker = $(el)
      unless $calendarPicker.data('initialized')
        @init $calendarPicker
        $calendarPicker.data('initialized', true)

  @initPlugin : () =>
    @initAll()

$ ->
  $(document).on 'ready page:load init-plugins', CalendarPicker.initPlugin