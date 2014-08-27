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
    @model.relationRemove() if confirm 'Вы действительно хотите удалить данную модель?'
    false

  render : () ->
    @$el.html @_getTemplateHtml()
    return this

  _getTemplateHtml : () ->
    """
      <span>#{@model.get('text')}</span>
      <button data-edit="#{@model.get('edit_url')}">Edit</button>
      <button data-remove>Delete</button>
    """

  @init : ($el) ->
    model = new Select2Input.RelatedModel
      id : $el.data('id')
      text : $el.find('span').text()
      edit_url : $el.find('[data-edit]').data('edit')
    new this
      el : $el
      model : model