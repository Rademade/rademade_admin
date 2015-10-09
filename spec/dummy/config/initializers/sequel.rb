db = Sequel.connect(YAML.load_file("#{::Rails.root}/config/sequel.yml")[::Rails.env])
db.extension :pagination
Sequel::Dataset::Pagination.send(:include, Kaminari::Sequel)