apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gem 'haml-rails'

gem_group :development do
  gem 'html2haml'
end

remove_file 'app/assets/stylesheets/application.css'
get_from_repo 'app/assets/stylesheets/application.css.sass'

remove_file 'app/assets/javascripts/application.js'
get_from_repo 'app/assets/javascripts/application.js.coffee'

after_bundle do
  run 'find . -name \*.erb -print | sed "p;s/.erb$/.haml/" | xargs -n2 bundle exec html2haml'
  run 'find . -name \*.erb -print | xargs rm'
end
