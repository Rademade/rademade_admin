SimpleForm.setup do |config|

  config.wrappers :rademade, :tag => 'label', :class => 'form-box' do |form_box|
    form_box.use :html5
    form_box.wrapper :tag => 'span', :class => 'form-label' do |form_label|
      form_label.use :label_text
    end
    form_box.wrapper :tag => 'span', :class => 'input-holder' do |input_holder|
      input_holder.use :input
    end
  end

  config.wrappers :rademade_login, :tag => 'div', :class => 'input-holder' do |form_box|
    form_box.use :html5
    form_box.use :placeholder
    form_box.use :input, :class => 'form-input'
    form_box.use :label, :class => 'form-label'
  end

end