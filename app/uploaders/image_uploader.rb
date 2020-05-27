class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  version :gallery do
    process resize_to_fill: [250,250]
  end

  version :thumb do
    process resize_to_fill: [50,50]
  end

  storage :fog
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
