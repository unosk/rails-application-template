apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gem 'kaminari'

run_bundle

generate 'kaminari:config'
