apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gsub_file 'config/application.rb', /# (config.i18n.load_path) .*/,
          "\\1 += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]"
gsub_file 'config/application.rb', /# (config.i18n.default_locale) .*/, '\1 = :ja'

remove_file 'config/locales/en.yml'
get 'https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/ja.yml', 'config/locales/default/ja.yml'
get_from_repo 'config/locales/views/default/ja.yml'
get_from_repo 'config/locales/models/default/ja.yml'
