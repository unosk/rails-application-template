CarrierWave.configure do |config|
  config.enable_processing = false
end

Dir[Rails.root.join('app/models/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('app/uploaders/**/*.rb')].each { |f| require f }

CarrierWave::Uploader::Base.descendants.each do |klass|
  next if klass.anonymous?
  klass.class_eval do
    def cache_dir
      "#{Rails.root}/spec/support/uploads/tmp"
    end

    def store_dir
      "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
    end
  end
end

RSpec.configure do |config|
  config.after(:all) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
  end
end
