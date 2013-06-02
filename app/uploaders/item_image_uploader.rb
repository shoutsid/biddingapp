class ItemImageUploader < CarrierWave::Uploader::Base
  include Sprockets::Rails::Helper
  include CarrierWave::RMagick

  storage :file

  version :largethumbnail do
    process resize_to_fit: [200, 200]
  end

  version :smallthumbnail do
    process resize_to_fit: [100, 100]
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected
  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end

end
