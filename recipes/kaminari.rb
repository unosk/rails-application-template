apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gem 'kaminari'

after_bundle do
  generate 'kaminari:config'
end
