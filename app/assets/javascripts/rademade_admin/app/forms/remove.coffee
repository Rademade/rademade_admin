$(document).on 'ready page:load', ->

  $('[data-delete-item-form]').on
    'ajax-before-submit' : (event, submitStart) ->
      submitStart() if confirm I18n.t('rademade_admin.remove_confirm.record')
    'ajax-submit-done' : ->
      $(this).closest('tr').fadeOut 300