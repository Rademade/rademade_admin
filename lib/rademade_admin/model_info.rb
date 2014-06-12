class ModelInfo

  attr_reader :model, :controller

  HAS_MANY_RELATIONS = [:embeds_many, :has_many, :has_and_belongs_to_many].freeze
  HAS_ONE_RELATIONS = [:has_one, :embeds_one, :belongs_to].freeze

  def initialize(model, controller, inner)
    @model, @controller, @inner = model, controller, inner
  end

  def parent_menu_item
    controller_class = ('rademade_admin/' + @controller + '_controller').camelize.constantize
    controller_class.instance_variable_get('@parent_item')
  end

  def nested?
    @inner
  end

  def has_many
    @has_many_relations ||= relations HAS_MANY_RELATIONS
  end

  def has_one
    @has_one_relations ||= relations HAS_ONE_RELATIONS
  end

  private

  def relations(types)
    @model.reflect_on_all_associations(*types).map do |x|
      x[:class_name] || relation_model(x[:name])
    end
  end

  def relation_model(name)
    name.to_s.capitalize
  end

end