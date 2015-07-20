SimpleForm.setup do |config|

  # config.wrappers :rademade, :tag => 'div', :class => 'form-box' do |form_box|
  #   form_box.use :html5
  #   form_box.wrapper :tag => 'label', :class => 'form-label' do |form_label|
  #     form_label.wrapper :tag => 'span', :class => 'text' do |label|
  #       label.use :label_text
  #     end
  #     form_label.wrapper :tag => 'span', :class => 'sign' do |hint|
  #       hint.use :hint
  #     end
  #   end
  #   form_box.wrapper :tag => 'div', :class => 'input-holder' do |input_holder|
  #     input_holder.use :input, :class => 'form-input'
  #   end
  # end

  config.wrappers :rademade_login, :tag => 'div', :class => 'input-holder' do |form_box|
    form_box.use :html5
    form_box.use :placeholder
    form_box.use :input, :class => 'form-input'
    form_box.use :label, :class => 'form-label'
  end

end