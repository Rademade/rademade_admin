SimpleForm.setup do |config|

  config.wrappers :rademade, :tag => 'div', :class => 'form-box' do |form_box|
    form_box.use :html5
    form_box.use :label, :class => 'form-label'
    form_box.wrapper :tag => 'span', :class => 'input-holder' do |input_holder|
      input_holder.use :input, :autocomplete => 'new-password'
    end
    form_box.wrapper :tag => 'div', :class => 'form-description', :unless_blank => true do |hint|
      hint.use :hint, :wrap_with => { :tag => :span, :class => :'form-description-text' }
    end
  end

  # TODO refactor to rademade_form
  config.wrappers :rademade_login, :tag => 'div', :class => 'input-holder' do |input_holder|
    input_holder.use :html5
    input_holder.use :placeholder
    input_holder.use :input, :class => 'form-input'
    input_holder.use :label, :class => 'form-label'
  end

  config.wrappers :empty, :tag => 'div', :class => 'form-box' do |form_box|
    form_box.use :html5
    form_box.use :input, :autocomplete => 'new-password'
  end

end