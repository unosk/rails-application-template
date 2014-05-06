REPOGITORY_RAW_URL = "https://raw.githubusercontent.com/unosk/rails-application-template/master"
TAG = "unosk"

def say_heading(text)
  say "\033[1m\033[36m" + TAG.to_s.rjust(10) + "\033[0m" + "  #{text}"
end

def copy(source, destination)
  remove_file destination
  get source, destination
end

unless Rails::VERSION::MAJOR.to_s == "4" && Rails::VERSION::MINOR.to_s == "1"
  raise StandardError.new "Rails #{Rails::VERSION::STRING} is not supported."
end

# Override Gemfile
say_heading "Override Gemfile"
copy "#{REPOGITORY_RAW_URL}/files/Gemfile", "Gemfile"
gsub_file "Gemfile", /@@Rails::VERSION::STRING@@/, Rails::VERSION::STRING

run "bundle install"

# Gitignore
say_heading "Setup Gemfile"
copy "#{REPOGITORY_RAW_URL}/files/gitignore.txt", ".gitignore"

# Disable discarded Generatos
say_heading "Disable discarded Generators"
inject_into_file "config/application.rb", after: "Rails::Application\n" do <<-EOF
    config.generators do |g|
      g.helper       false
      g.stylesheets  false
      g.javascripts  false
      g.view_specs   false
      g.helper_specs false
    end

  EOF
end

# Cleanup routes.rb
gsub_file "config/routes.rb", /  #.*\n/, "\n"
gsub_file "config/routes.rb", /\n^\s*\n/, "\n"

# Set TimeZone
say_heading "Set TimeZone"
gsub_file "config/application.rb", /# config\.time_zone.*/, "config.time_zone = 'Asia/Tokyo'"

# Set Locale
say_heading "Set Locale"
gsub_file "config/application.rb", /# config\.i18n.load_path.*/, "config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]"
gsub_file "config/application.rb", /# config\.i18n\.default_locale.*/,  "config.i18n.default_locale = :ja"
copy "https://raw.githubusercontent.com/svenfuchs/rails-i18n/master/rails/locale/ja.yml", "config/locales/ja.yml"
remove_file "config/locales/en.yml"

# Replace CSS to SASS
say_heading "Replace CSS to SASS"
remove_file "app/assets/stylesheets/application.css"
create_file "app/assets/stylesheets/application.css.sass", <<-EOF
@import compass
@import compass/reset
EOF

# Replace JS to CoffeeScript
say_heading "Replace JS to CoffeeScript"
remove_file "app/assets/javascripts/application.js"
create_file "app/assets/javascripts/application.js.coffee", <<-EOF
#= require jquery
#= require jquery_ujs
#= require turbolinks
EOF

# Replace ERB to Haml
say_heading "Replace ERR to Haml"
run "find . -name \*.erb -print | sed 'p;s/.erb$/.haml/' | xargs -n2 html2haml"
run "find . -name \*.erb -print | xargs rm"

# Initialize Rspec
say_heading "Initialize Rspec"
generate "rspec:install"
append_file ".rspec", "--format documentation"
copy "#{REPOGITORY_RAW_URL}/files/spec/factories_spec.rb", "spec/factories_spec.rb"
%w(capybara database_cleaner factory_girl).each do |support|
  copy "#{REPOGITORY_RAW_URL}/files/spec/support/#{support}.rb", "spec/support/#{support}.rb"
end
copy "#{REPOGITORY_RAW_URL}/files/simplecov.txt", ".simplecov"
inject_into_file "spec/spec_helper.rb", after: "require 'rspec/rails'\n" do <<-EOF
require 'shoulda/matchers'
require 'simplecov'
EOF
end

# Initialize Guard
say_heading "Initialize Guard"
run "bundle exec guard init"

# Create binstubs
say_heading "Create binstubs"
%w(rspec-core guard annotate spring).each do |stub|
  run "bundle binstub #{stub}"
end
