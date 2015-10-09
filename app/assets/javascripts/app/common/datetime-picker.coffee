class FilthypillowCalendar

  constructor: (element) ->
    @$calendarElement = $(element)
    @$parent = @$calendarElement.parent()

  init : () ->
    minDateTime = moment().subtract( "seconds", 1 )
    @$calendarElement.filthypillow()
    @_bindCalendarListeners()
    @_bindParentListeners()

  _bindCalendarListeners : () ->
    @$calendarElement.on 'focus', () =>
      @$calendarElement.filthypillow 'show'

    @$calendarElement.on 'fp:save', (e, dateObj) =>
      @$calendarElement.val dateObj.format('DD.MM.YYYY HH:mm')
      @$calendarElement.filthypillow 'hide'

  _bindParentListeners : () ->
    @$parent.on 'fp:show', (event) =>
      event.stopPropagation()
      @$parent.addClass('is-active')

    @$parent.on 'fp:hide', (event) =>
      event.stopPropagation()
      @$parent.removeClass('is-active')

$ ->
  $(document).on 'ready page:load init-plugins', () ->
    $('[data-date-time-picker]').each () ->
      new FilthypillowCalendar(this).init()