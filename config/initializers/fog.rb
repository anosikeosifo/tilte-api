CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    region: "us-west-2", #ENV["AWS_REGION"],
    aws_access_key_id: "AKIAJRKPUPAHFRDQPMXQ", #ENV["AWS_ACCESS_KEY_ID"] 
    aws_secret_access_key: "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" #ENV["AWS_SECRET_ACCESS_KEY"] 
  }

  if Rails.env.production?
    config.root = Rails.root.join('tmp')
    config.cache_dir = "#{Rails.root}/tmp/uploads"
  end

  config.fog_directory = "tilteposts" #ENV["AWS_BUCKET"]
  config.fog_public = false
end