$ ->
  $.ajaxSetup(headers : {
    'X-CSRF-Token' : $('meta[name="csrf-token"]').attr('content')
  })

  $(document).on 'page:load ready init-plugins', () ->
    $('table.fixed-thead').floatThead
      position: 'fixed'
