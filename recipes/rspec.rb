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
  gem 'webmock'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

after_bundle do
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
require 'webmock/rspec'
require 'simplecov'), after: '# Add additional requires below this line. Rails is not loaded until this point!'

  %w(capybara database_cleaner email shoulda_matchers).each do |support|
    get_from_repo "spec/support/#{support}.rb"
  end

  get_from_repo '.simplecov'

  append_file '.gitignore', %(
# Ignore coverage.
/coverage
)
end
