class @Select2Input.Model extends Backbone.Model

  isMultiple : () ->
    @get('multiple')

  getData : () ->
    @get('related').getData()