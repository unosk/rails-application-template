apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gem 'devise'
gem 'devise-encryptable'
gem 'devise-i18n'

run_bundle

generate 'devise:install'

gsub_file 'config/initializers/devise.rb', /# (config.scoped_views) .*/, '\1 = true'

remove_file 'config/locales/devise.en.yml'

get_from_repo 'spec/support/devise.rb'
