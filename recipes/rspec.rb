apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gem_group :development, :test do
  gem 'rspec-rails'
end

gem_group :development do
  gem 'spring-commands-rspec'
end

gem_group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'shoulda-matchers', require: false
  gem 'simplecov', require: false
  gem 'simplecov-rcov', require: false
end

run_bundle

run './bin/spring binstub --all'

generate 'rspec:install'

append_file '.rspec', <<-CODE
--require rails_helper
--format documentation
CODE

gsub_file 'spec/rails_helper.rb', /(config.use_transactional_fixtures) = .*/, '\1 = true'
gsub_file 'spec/rails_helper.rb', /# Dir/, 'Dir'
inject_into_file 'spec/rails_helper.rb', %(
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'shoulda/matchers'
require 'simplecov'), after: '# Add additional requires below this line. Rails is not loaded until this point!'

get_from_repo 'spec/factories_spec.rb'

%w(capybara database_cleaner email).each do |support|
  get_from_repo "spec/support/#{support}.rb"
end

get_from_repo '.simplecov'

append_file '.gitignore', %(
# Ignore coverage.
/coverage
)
