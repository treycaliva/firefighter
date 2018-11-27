module Firefighter
  class RealtimeDatabase
    include Web

    def self.from_env
      config = {
        db_name: ENV['FIREBASE_WEB_DB_NAME'],
        db_secret: ENV['FIREBASE_WEB_DB_SECRET']
      }
      new(config)
    end

    def initialize(db_name:, db_secret:)
      @db_name = db_name
      @db_secret = db_secret
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
      call(:get, url)
    end

    private

    def endpoint(path)
      "https://#{@db_name}.firebaseio.com/#{path}.json?auth=#{@db_secret}"
    end
  end
end
