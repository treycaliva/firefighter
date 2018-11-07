require 'logger'
require 'json'
require 'http'

module Firefighter
  module Web
    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def call(method, url, data = {})
      if method == :get
        response = HTTP.get(url, headers: {'Content-Type' => 'application/json'})
      else
        response = HTTP.send(method, url, headers: {'Content-Type' => 'application/json'}, body: JSON.dump(data))
      end
      if response.status == 200
        JSON.parse(response.body)
      else
        logger.warn "firebase #{method} failed #{url} #{response.body}"
        raise "firebase #{method} failed #{url} #{response.body}"
      end
    end
  end
end
