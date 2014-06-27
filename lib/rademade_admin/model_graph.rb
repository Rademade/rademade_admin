class ModelGraph
  include Singleton

  def add_pair(resource_name, controller, inner)
    controller ||= resource_name.to_s.tableize
    #todo folder of admin controllers
    controller_name = ('rademade_admin/' + controller + '_controller')

    model = controller_name.camelize.constantize.model_class

    @models[model.to_s] ||= ModelInfo.new(model, controller, controller_name, inner)
  end

  def model_info(model)
    @models[model.to_s]
  end

  def root_models
    @root_models ||= get_root_models
  end

  private

  def initialize
    @models = {}
  end

  def get_root_models
    @models.select { |model, info| !info.nested? }.values
  end

end
