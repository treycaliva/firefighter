require 'logger'
require 'json'
require 'http'

module Firefighter
  module Web
    def logger
      @logger ||= Logger.new(STDOUT)
    end

    def call(method, url, data = {}, headers = {})
      case method
      when :get
        response = HTTP.get(url, headers: headers)
      when :delete
        response = HTTP.delete(url, headers: headers)
      when :form
        response = HTTP.send(:post, url, form: data, headers: headers)
      else
        response = HTTP.send(method, url, json: data, headers: headers)
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
