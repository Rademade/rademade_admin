require 'jwt'
module RademadeAdmin

  class UserPasswordToken

    class << self

      def encode(user, meta = {})
        @meta = meta
        JWT.encode(encode_payload(user), secret(user))
      end

      def decode(token)
        payload = decoded_payload(token)
        raise Error.new('Invalid payload') unless valid_payload?(payload)
        user = RademadeAdmin.configuration.admin_class.get_by_email(payload['email'])
        JWT.decode(token, secret(user))
        user
      end

      private

      def encode_payload(user)
        {
          email: user.email
        }.reverse_merge!(meta)
      end

      def decoded_payload(token)
        JWT::Decode.new(token, nil).decode_segments[1]
      end

      def secret(user)
        "#{user.encrypted_password}#{Rails.application.secrets.secret_key_base}"
      end

      def valid_payload?(payload)
        !expired?(payload) && payload['email']
      end

      def meta
        {
          exp: 30.minutes.from_now.to_i,
          iss: 'Rademade admin user',
          iat: Time.now,
          aud: 'admin user'
        }.merge(@meta)
      end

      def expired?(payload)
        Time.at(payload['exp']).past?
      end

    end
  end

end

