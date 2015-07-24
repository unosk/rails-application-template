apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gsub_file 'config/routes.rb', /^\s*#.*\n/, ''
