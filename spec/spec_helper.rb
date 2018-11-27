require "bundler/setup"
require "firefighter"
require "timecop"
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/support/cassettes"
  config.hook_into :webmock # or :fakeweb
  config.default_cassette_options = { record: :new_episodes }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

# firebase account for the sole purpose of testing
ENV['FIREBASE_WEB_DB_NAME']                 = "ruby-firefighter"
ENV['FIREBASE_WEB_DB_SECRET']               = "gzY8aJHle1uetWzEWEfNrokgpj0qKDO97dgoOTrv"
ENV['FIREBASE_WEB_API_KEY']                 = "AIzaSyC9Sr5Hd__ixE5YTCanrgxH3b2IQnJqIho"
ENV['FIREBASE_SERVER_ID']                   = "632392298254"
ENV['FIREBASE_SERVER_KEY']                  = "AAAAkz2Erw4:APA91bEUFlQCshmSalr5Do6WhJ3dtOXVR1WkJ9wLIgB6PlmFmY6S7hNTheH4IdkzRfuNYwAExoG_-GwIG1SQUO9t9oAUdUtXo08b-jxnjyGEzlfAxxUbq3GKFtiSvhAB6mFBZkKmF53VQ5GZZTiBlnkPzZWEwmGy1Q"
ENV['FIREBASE_SERVICE_ACCOUNT_EMAIL']       = "firebase-adminsdk-zsizj@ruby-firefighter.iam.gserviceaccount.com"
ENV['FIREBASE_SERVICE_ACCOUNT_PRIVATE_KEY'] = "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDalXixom6iL8Sm\njO7It3DRoECGx+76qBxbXhSqd2eK/9gvc6D6b84MQuhF/G1cG+hiZJzetQxUXNDv\nc6Oat1VUVqEUsuvnr7rOkotBoz+beBsjxZU8qxdOKGsDUh5eqEVXhMz321ask07X\n7ydjA6IePr48xXeJHQ8c+wQqjx6NJy+YJpeIXaqCvVrFvHl7KuzYQZL2CgjATuzA\nLjVr8LAd90xJC5iEGW9Cni0mFJ7OQSd5XEDV1UmKbfHeevyuA3u1Xb9uXD3ejd/z\ntf/sk1B9hLUbqtVIw2HzaYMmZXQJETiosZE4mSxU+jxF2AqW93Iso6n40QU6JAhZ\nLY7Mus1fAgMBAAECggEAEsDNgLqlheyrO87OPbzfRQeGrF7tizvDvbhYoDdrqWqX\nKvBfWJ0hrxOece1c7ztwYzYBRL+BC0vbRm/uvWYKlW3JQXQIS/GxCUAGtTRC+h0C\ngb3V4UVHKUF2d5Z4Bzml7q2fbYm36fPJc+U6GoND9BcAo0jIdKRgQ5BAT0Ea0ek+\nEb9OjAMZf9zC93Cjo5NBcsUNIzqwlDKOBJFUGtFxAmGesLE8Tj9yOH6ObiGxiQL7\nlYyUUJnSYd3FFpfxuXPG5ra1BsoVKcDiIhw5IMH+MoSZfJELp3wVKA2b2axyouD+\nBVe+WsBpsHONx+58cnFuteK/Axk/HIac8PDLwY+3QQKBgQD86r0E9zmujxiFehYO\nPoC0dwwuK1srYG9YjgmEbANM1azGZXkpNF8a2xnmH9IV1ecnYk65TfEhT7Hosvnp\nmtEP89jmVPFlZa48f94AoBd9Am6utf2gOTknQ3iAkUz/2dxpG2sBuObj1wrmtP5I\nn2o4MkRuSCLGhiAVCb9jAbq7RwKBgQDdP5eTJPJwfr3Gt3upojd/rbThxiNPEWtJ\nFLr4cd0v3zWm3mpSrnEJEfIVhGcYepq/SrTvKgCNrzlCtAwUCx2FkHSXKhdv0kMU\nxueSpl6c8WW7jbA7iDyd771aZZv9tzTFEJCD2dda2MGUyO5xALGJiOfXze3yb4U/\n4bcMTOA5KQKBgCJuapE0fvvOq03wkvQZejgXROc8K8s5866gl5cZhVF+fWj9A4Oi\nh5gGX/4+MsGaPz/TWFhNzhf024mMZA1zcCa10b95rOta7l96IOUA5nG0VREf4Ylg\ngPFhdBQ8s7jZFfKRMv4nB/fYnLlPxpZobXN9FGfXFjTkqZVzoESARcWdAoGBAJtR\nBCA45LUSVDlHH1njVeCc2glQ5gKgsNcZ5XN5w5PSt0BQjQVEDngWkAKI8zLdBvtY\n/5GRw9ey9Zic+omrj+rukNp5owBN8+eHBpQNlQfJ8ufqPJheOGeLIDtwb0R6M2JQ\nEZNt/t94oNTJBZJwsTFi2ZbGqs7xePJyiuToptOZAoGABLVMaZYrZ/HpTSmGiKXW\nfch8X1hqzRpimlA7qbUVATznkDGNOmJfy3ShkWSjzWOf/Tb2gjOeyDi8hyICUvmK\ns5F60PYLzz/s/ZqwDxxwsKix9skBuDjoPAkPmC8DTkJ1NX2gR3zu6dsj6dvs9B41\nj5NRQqv9CPsW8nnIpAmPBv0=\n-----END PRIVATE KEY-----\n"
