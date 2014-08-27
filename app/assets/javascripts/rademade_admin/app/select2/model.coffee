class @Select2Input.Model extends Backbone.Model

  isMultiple : () ->
    @get('multiple')

  getRelatedData : () ->
    @get('related').getData()