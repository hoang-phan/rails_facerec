FR_ENV = YAML.load_file(Rails.root.join('config', 'credentials.yml'))
$gcm = GCM.new(FR_ENV['gcm_api_key'])