require 'rademade_admin/bower/performer'

desc 'Install bower vendor assets'
task 'rademade_admin:bower:install' => :environment do |_, args|
  args.with_defaults(:options => '')
  RademadeAdmin::Bower::Performer.perform do |bower|
    sh "#{bower} install #{args[:options]}"
  end
end

desc 'Update bower vendor assets'
task 'rademade_admin:bower:update' => :environment do |_, args|
  args.with_defaults(:options => '')
  RademadeAdmin::Bower::Performer.perform do |bower|
    sh "#{bower} update #{args[:options]}"
  end
end