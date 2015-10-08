namespace :sequel do

  desc 'Run migrations'
  task :migrate, [:version] do |_, args|
    Sequel.extension :migration
    db = Sequel.connect(YAML.load_file("#{::Rails.root}/config/sequel.yml")[::Rails.env])
    migration_directory = 'db/sequel'
    options = { table: 'sequel_migrations' }
    if args[:version]
      Sequel::Migrator.run(db, migration_directory, options.merge(target: args[:version].to_i))
    else
      Sequel::Migrator.run(db, migration_directory, options)
    end
  end

end