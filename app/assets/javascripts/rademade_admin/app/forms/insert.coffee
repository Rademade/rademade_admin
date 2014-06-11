$(document).on 'ready page:load', ->

	$('.insert-item-form').on
    'ajax-submit-done': (event , data)->
      $(this)
        .attr('action', data.form_action)
        .append('<input name="_method" type="hidden" value="patch">')