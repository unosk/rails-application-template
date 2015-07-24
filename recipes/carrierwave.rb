apply File.join(File.dirname(__FILE__), '..', 'helpers.rb') unless defined? TEMPLATE_HELPERS

gem 'carrierwave'
gem 'mini_magick'
gem 'mime-types'
gem_group :development, :test do
  gem 'dummy_magick'
end

get_from_repo 'app/uploaders/application_uploader/base.rb'
get_from_repo 'app/uploaders/application_uploader/image.rb'

get_from_repo 'spec/support/carrierwave.rb'

append_file '.gitignore', %(
# Ignore uploaded files.
/public/uploads
/spec/support/uploads
)
