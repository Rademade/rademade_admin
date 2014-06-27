#todo move to routing dir
class ModelInfo

  attr_reader :model, :controller

  HAS_MANY_RELATIONS = [:embeds_many, :has_many, :has_and_belongs_to_many].freeze
  HAS_ONE_RELATIONS = [:has_one, :embeds_one, :belongs_to].freeze

  def initialize(model, controller, controller_name, inner)
    @model, @controller, @controller_name, @inner = model, controller, controller_name, inner
  end

  # todo move back
  def new_model(filtered_params = {})
    @model.new(filtered_params)
  end

  # todo move back
  def find(id)
    @model.find(id)
  end

  def parent_menu_item
    @controller_name.camelize.constantize.instance_variable_get('@parent_item')
  end

  def nested?
    @inner
  end

  # todo move realization to data_adapter
  # todo move to data module
  def relations
    @model.relations
  end

  # todo move realization to data_adapter
  def reflect_on_association(name)
    @model.reflect_on_association(name)
  end

  # todo move to module
  def uploaders
    @model.respond_to?(:uploaders) ? @model.uploaders : []
  end

  # todo move to module
  def uploader_fields
    @model.respond_to?(:uploaders) ? @model.uploaders.keys : []
  end

  # todo move realization to data_adapter
  # todo move to data module
  def has_many
    @has_many_relations ||= relations_with_types HAS_MANY_RELATIONS
  end

  # todo move realization to data_adapter
  # todo move to data module
  def has_one
    @has_one_relations ||= relations_with_types HAS_ONE_RELATIONS
  end

  # todo move realization to data_adapter
  # todo move to data module
  def fields
    @model.fields
  end

  # todo move to data module
  def has_field?(field)
    fields.keys.include? field
  end

  # @doc
  # Admin::User => :users
  # RademadeAdmin::User::Adapter => :adapters
  def model_related_name
    @model.to_s.demodulize.pluralize.downcase.to_sym
  end

  # todo move to data module
  def association_fields
    @model.relations.keys.map &:to_sym
  end

  def data_adapter
    # todo case
    # create some noise
  end

  private

  # todo move to data_adapter
  def relations_with_types(types)
    @model.reflect_on_all_associations(*types).map do |relation|
      relation[:class_name] || relation[:name].to_s.capitalize
    end
  end

end

#Searcher.new(model_info).find params