#todo move to routing dir
class ModelInfo

  attr_reader :model, :controller

  HAS_MANY_RELATIONS = [:embeds_many, :has_many, :has_and_belongs_to_many].freeze
  HAS_ONE_RELATIONS = [:has_one, :embeds_one, :belongs_to].freeze

  def initialize(model, controller, controller_name, inner)
    @model, @controller, @controller_name, @inner = model, controller, controller_name, inner
  end

  def new_model(filtered_params = {})
    @model.new(filtered_params)
  end

  def find(id)
    @model.find(id)
  end

  def parent_menu_item
    @controller_name.camelize.constantize.instance_variable_get('@parent_item')
  end

  def nested?
    @inner
  end

  def relations
    @model.relations
  end

  def reflect_on_association(name)
    @model.reflect_on_association(name)
  end

  def uploaders
    @model.respond_to?(:uploaders) ? @model.uploaders : []
  end

  def uploader_fields
    @model.respond_to?(:uploaders) ? @model.uploaders.keys : []
  end

  def has_many
    @has_many_relations ||= relations_with_types HAS_MANY_RELATIONS
  end

  def has_one
    @has_one_relations ||= relations_with_types HAS_ONE_RELATIONS
  end

  def fields
    @model.fields
  end

  def has_field?(field)
    @model.fields.keys.include? field
  end

  def model_related_name
    @model.to_s.demodulize.pluralize.downcase.to_sym
  end

  def association_fields
    @model.relations.keys.map &:to_sym
  end

  private

  def relations_with_types(types)
    @model.reflect_on_all_associations(*types).map do |x|
      x[:class_name] || relation_model(x[:name])
    end
  end

  def relation_model(name)
    name.to_s.capitalize
  end

end