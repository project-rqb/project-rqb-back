module JwtAuthenticator
  class UnableAuthorizationError < StandardError; end

  def authenticate
    authorization_header = request.headers['Authorization']
    encoded_token = authorization_header.split('Bearer ').last
    decoded_token_payload = decode(encoded_token)
    @current_user = UserAuthentication.find_by(uid: decoded_token_payload["uid"]).user
  end

  def encode_access_token(uid_info)
    exp_info = Time.now.to_i + 12 * 3600
    payload = { uid: uid_info, exp: exp_info }
    JWT.encode(payload, ENV['JWT_SECRET_KEY'], 'HS256')
  end

  def decode(encoded_token)
    decoded_token = JWT.decode(encoded_token, ENV['JWT_SECRET_KEY'], true, algorithm: 'HS256')
    decoded_token.first
  rescue JWT::DecodeError => e
    raise UnableAuthorizationError.new("トークンの復号化に失敗しました: #{e.message}")
  end
end
