module Firefighter
  class Identitytoolkit
    include Web

    def self.from_env
      config = {
        api_key: ENV['FIREBASE_WEB_API_KEY']
      }
      new(config)
    end

    def initialize(api_key:)
      @api_key = api_key
    end

    def signup(email, password)
      url = endpoint('signupNewUser')
      data = {
        email: email,
        password: password,
        returnSecureToken: true
      }
      call(:post, url, data)
    end

    private

    def endpoint(path)
      "https://www.googleapis.com/identitytoolkit/v3/relyingparty/#{path}?key=#{@api_key}"
    end
  end
end
