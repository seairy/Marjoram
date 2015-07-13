# encoding: utf-8
class CkeditorPictureUploader < BaseUploader
  include Ckeditor::Backend::CarrierWave
  process :read_dimensions

  version :thumb do
    process resize_to_fit: [160, 120]
  end

  version :w1800_h1350_ft_q80 do
    process quality: 80
    process resize_to_fit: [1800, 1350]
  end

  version :w800_h600_ft_q80 do
    process quality: 80
    process resize_to_fit: [800, 600]
  end

  version :w640_h480_ft_q80 do
    process quality: 80
    process resize_to_fit: [640, 480]
  end
end