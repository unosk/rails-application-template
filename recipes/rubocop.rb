apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gem_group :development, :test do
  gem 'rubocop'
end

run_bundle

get_from_repo '.rubocop.yml'
get_from_repo '.rubocop_todo.yml'
