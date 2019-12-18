module Firefighter
  class Identitytoolkit
    include Web

    def self.from_env
      config = {
        api_key: ENV['FIREBASE_WEB_API_KEY'],
        service_account_email: ENV['FIREBASE_SERVICE_ACCOUNT_EMAIL'],
      }
      new(config)
    end

    def initialize(api_key:, service_account_email:)
      @api_key = api_key
      @service_account_email = service_account_email
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

    def account_info(id_token, local_ids: [],	emails: [])
      url = endpoint('getAccountInfo')
      data = {
        idToken: id_token,
        localId: local_ids,
        email: emails,
      }
      response = call(:post, url, data)

      response["users"].first["customClaims"] = [JSON.parse(response["users"].first["customAttributes"], symbolize_names: true)] if response["users"].first["customAttributes"]
      response
    end

    def download_accounts(access_token = TokenGenerator.from_env.fetch_access_token)
      users = []

      headers = {Authorization: "Bearer #{access_token}" }
      url = endpoint('downloadAccount')
      paginate(url, headers: headers) { |data| users << data['users'] }

      users.flatten.compact
    end

    private

    def paginate(url, method: :post, headers: {}, page_size: 100, max_iterations: 1000)
      next_page_token = nil

      max_iterations.times do
        data = {
          nextPageToken: next_page_token,
          maxResults: page_size,
        }
        data = call(method, url, data, headers)

        yield data

        return if data['nextPageToken']&.empty? || data['nextPageToken'] == next_page_token

        next_page_token = data['nextPageToken']
      end
    end

    def endpoint(path)
      "https://www.googleapis.com/identitytoolkit/v3/relyingparty/#{path}?key=#{@api_key}"
    end
  end
end
