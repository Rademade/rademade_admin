$(document).on 'ready page:load', ->

  $('.delete-item-form').on
    'ajax-before-submit' : (event, submitStart) ->
      submitStart() if confirm I18n.t('rademade_admin.record_remove_confirm')
    'ajax-submit-done' : ->
      $(this).closest('tr').fadeOut 300
