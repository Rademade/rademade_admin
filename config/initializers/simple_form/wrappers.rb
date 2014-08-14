SimpleForm.setup do |config|

  config.wrappers :rademade, :tag => 'div', :class => 'input-holder' do |b|
    b.use :html5
    b.use :label
    b.use :input
    b.use :hint, :wrap_with => { :tag => 'div', :class => 'hint' }
  end

end