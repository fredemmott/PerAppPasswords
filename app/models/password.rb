require 'openssl'

class Password < ActiveRecord::Base
  def password= password
    normalized = password.downcase.gsub(' ', '')
    self.salt = ActiveSupport::SecureRandom.hex(16)
    self.hmac = OpenSSL::HMAC.hexdigest('sha256', normalized, self.salt)
  end

  def correct_password? password
    normalized = password.downcase.gsub(' ', '')
    self.hmac == OpenSSL::HMAC.hexdigest('sha256', normalized, self.salt)
  end
end
