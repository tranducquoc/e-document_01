class AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  if Rails.env.production?
    storage :fog
  else
    storage :file

    def extension_white_list
      %w(pdf doc htm html docx)
    end
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def cover
    manipulate! do |frame, index|
      frame if index.zero? # take only the first page of the file
    end
  end

  version :preview do
    process :cover
    process resize_to_fit: [310, 280]
    process convert: :jpg

    def full_filename (for_file = model.source.file)
      super.chomp(File.extname(super)) + Settings.jpg
    end
  end
end
