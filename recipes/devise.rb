apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gem 'devise'
gem 'devise-encryptable'

run_bundle

generate 'devise:install'

gsub_file 'config/initializers/devise.rb', /# (config.scoped_views) .*/, '\1 = true'

get 'https://raw.githubusercontent.com/tigrish/devise-i18n/master/config/locales/ja.yml', 'config/locales/devise.ja.yml'
remove_file 'config/locales/devise.en.yml'

get_from_repo 'spec/support/devise.rb'
