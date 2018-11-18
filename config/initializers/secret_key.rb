class SecretKey

  def self.aes_key
    "#{Rails.application.secrets.aes_key}"
  end
  
end