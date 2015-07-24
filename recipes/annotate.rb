apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gem_group :development do
  gem 'annotate'
end

after_bundle do
  generate 'annotate:install'
end
