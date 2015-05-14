CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => ENV["AWS_KEY_ID"],
    :aws_secret_access_key  => ENV["AWS_KEY"],
    :region                 => 'eu-central-1'
  }
  config.fog_directory = 'bulletinboardimages'
  config.fog_public = false
  config.fog_attributes = {'Cache-Control'=>"max-age=#{365.day.to_i}"}
  config.cache_dir = "#{Rails.root}/tmp/uploads"
end
