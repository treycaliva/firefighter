require 'logger'
require 'json'
require 'http'

module Firefighter
  class RealtimeDatabase
    def self.from_env
      config = {
        api_key: ENV['FIREBASE_WEB_API_KEY'],
        db_name: ENV['FIREBASE_WEB_DB_NAME'],
        db_secret: ENV['FIREBASE_WEB_DB_SECRET']
      }
      new(config)
    end

    def initialize(api_key:, db_name:, db_secret:, logger: Logger.new(STDOUT))
      @api_key = api_key
      @db_name = db_name
      @db_secret = db_secret
      @logger = logger
    end

    def signup(email, password)
      url = "https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=#{@api_key}"
      data = {
        email: email,
        password: password,
        returnSecureToken: true
      }
      call(:post, url, data)
    end

    def write(path, data)
      url = endpoint(path)
      call(:put, url, data)
    end

    def add(path, data)
      url = endpoint(path)
      call(:post, url, data)
    end

    def read(path)
      url = endpoint(path)
      get(url)
    end

    private

    def call(method, url, data)
      response = HTTP.send(method, url, headers: {'Content-Type' => 'application/json'}, body: JSON.dump(data))
      if response.status == 200
        JSON.parse(response.body)
      else
        @logger.warn "firebase #{method} failed #{url} #{response.body}"
        raise "firebase #{method} failed #{url} #{response.body}"
      end
    end

    def get(url)
      response = HTTP.get(url, headers: {'Content-Type' => 'application/json'})
      if response.status == 200
        JSON.parse(response.body)
      else
        @logger.warn "firebase get failed #{url} #{response.body}"
        raise "firebase get failed #{url} #{response.body}"
      end
    end

    def endpoint(path)
      "https://#{@db_name}.firebaseio.com/#{path}.json?auth=#{@db_secret}"
    end
  end
end
