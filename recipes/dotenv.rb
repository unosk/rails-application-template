apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gem_group :development, :test do
  gem 'dotenv-rails'
end

append_file '.gitignore', %(
/.env
)
