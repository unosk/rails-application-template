apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gem_group :development, :test do
  gem 'factory_girl_rails'
end

get_from_repo 'spec/support/factory_girl.rb'
