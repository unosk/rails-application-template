apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gem_group :development, :test do
  gem 'thin'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'awesome_print'
end

gem_group :development do
  gem 'quiet_assets'
end
