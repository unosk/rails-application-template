class ApplicationUploader::Image < ApplicationUploader::Base
  include CarrierWave::MiniMagick

  process :cleanup

  def cleanup
    manipulate! do |img|
      img.auto_orient
      img.strip
      img = yield(img) if block_given?
      img
    end
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
