require 'jwt'

class JsonWebToken
  SECRET_KEY = ENV['JWT_SECRET_KEY']

  # Encode JWT token with expiration
  def self.encode(payload, exp = 15.seconds.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  # Decode JWT token
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
    HashWithIndifferentAccess.new(decoded[0])
  rescue JWT::ExpiredSignature
    raise JWT::ExpiredSignature
  rescue JWT::DecodeError
    raise JWT::DecodeError
  rescue
    nil
  end
end
