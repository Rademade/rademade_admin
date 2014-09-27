initDatetimePicker = () ->
  $('[data-date-time-picker]').each () ->
    $(this).datetimepicker
       dateFormat: 'dd.mm.yy'

$ ->
  $(document).on 'ready page:load init-plugins', initDatetimePicker