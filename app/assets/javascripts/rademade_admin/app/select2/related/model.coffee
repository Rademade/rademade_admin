class @Select2Input.RelatedModel extends Backbone.Model

  relationRemove : () ->
    @trigger 'relation-remove', this

  # todo mixin
  update : (data) ->
    @set data
    @_triggerChange()

  getData : () ->
    @attributes

  _triggerChange : () ->
    @trigger 'data-change'