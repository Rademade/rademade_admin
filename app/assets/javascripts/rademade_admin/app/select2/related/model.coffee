class @Select2Input.RelatedModel extends Backbone.Model

  relationRemove : () ->
    @trigger 'relation-remove', this