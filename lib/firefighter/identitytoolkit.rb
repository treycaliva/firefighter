module Firefighter
  class RealtimeDatabase
    include Web

    def self.from_env
      config = {
        db_secret: ENV['FIREBASE_WEB_DB_SECRET']
      }
      new(config)
    end

    def initialize(db_secret:)
      @db_secret = db_secret
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
