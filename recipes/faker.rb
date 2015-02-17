apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gem_group :development, :test do
  gem 'faker'
  gem 'faker-japanese'
end

run_bundle

get_from_repo 'config/initializers/faker.rb'
