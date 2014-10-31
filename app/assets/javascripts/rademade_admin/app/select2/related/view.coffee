class @Select2Input.RelatedView extends Backbone.View

  tagName : 'li'

  events :
    'click [data-edit]' : 'editRelation'
    'click [data-remove]' : 'removeRelation'

  initialize : () ->
    @model.on 'relation-remove', @remove, this
    @model.on 'change', @render, this

  editRelation : (e) ->
    e.preventDefault()
    FormPopup.Initializer.getInstance().showPopup @model

  removeRelation : (e) ->
    e.preventDefault()
    @model.relationRemove() if confirm I18n.t('rademade_admin.model_remove_confirm')
    false

  render : () ->
    @$el.html @_getHtml(@model.toJSON())
    return this

  _getHtml : (data) ->
    JST['rademade_admin/app/templates/related-item'](data)

  @init : ($el) ->
    model = new Select2Input.RelatedModel
      id : $el.data('id')
      text : $el.find('span').text()
      edit_url : $el.find('[data-edit]').data('edit')
    new this
      el : $el
      model : model