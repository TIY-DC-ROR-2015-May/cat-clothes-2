CarrierWave.configure do |config|
  config.root = Rails.root.join('tmp')
  config.cache_dir = 'carrierwave'

  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV["aws_access_key_id"],
    :aws_secret_access_key  => ENV["aws_secret_access_key"]
  }
  config.fog_directory  = 'cat-clothes-uploads'
end