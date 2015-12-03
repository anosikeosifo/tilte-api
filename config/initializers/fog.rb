CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    region: "eu-west-1",
    aws_access_key_id: Rails.application.secrets.aws_access_key_id,
    aws_secret_access_key: Rails.application.secrets.aws_secret_access_key
  }

  if Rails.env.production?
    config.root = Rails.root.join('tmp')
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end

  config.fog_directory = "tilteposts" #ENV["AWS_BUCKET"]
  config.fog_public = true
end
