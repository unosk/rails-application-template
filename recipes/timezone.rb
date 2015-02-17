apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gsub_file 'config/application.rb', /# (config.time_zone) .*/, "\\1 = 'Tokyo'"
