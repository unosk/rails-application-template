class ApplicationUploader::Base < CarrierWave::Uploader::Base
  include CarrierWave::MimeTypes

  process :set_content_type

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as.to_s.gsub('_image', '')}"
  end

  def filename
    "#{secure_token}.#{file.extension.downcase}" if original_filename.present?
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, SecureRandom.hex(4))
  end
end
