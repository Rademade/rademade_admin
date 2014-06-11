$(document).on 'ready page:load', ->

  $('.delete-item-form').on
    'ajax-before-submit': (event, submitStart) -> submitStart() if confirm 'Do you really want delete this record?',
    'ajax-submit-done': -> $(this).closest('tr').fadeOut 300

