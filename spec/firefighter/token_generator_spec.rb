RSpec.describe Firefighter::TokenGenerator do
  let(:uid) { 'some-uid' }
  let(:data) { { 'fire' => 'hose' } }
  let(:custom_token_file) { File.read('spec/support/files/custom_token_jwt.example').chomp }
  let(:access_token_file) { File.read('spec/support/files/access_token_jwt.example').chomp }
  let(:token_data) { "ya29.c.ElpNBgzYH5OmuaNlmJUHKYgXve2OmSiaFPwF-Xw2qIt3uMaDS5EMnpWTPS0NyJAzRrusnvnBIONi3Nq9YhRdzCgF2DgwsPm9xhXHGi0aVMVBq7qoGI8D2Wsuf78" }

  it "generes proper access_tokens" do
    Timecop.freeze(Time.utc(2017, 1, 1, 12, 0, 0)) do
      token = Firefighter::TokenGenerator.from_env.create_access_token

      expect(token).to eql(access_token_file)
    end
  end

  it "generes proper custom_tokens" do
    Timecop.freeze(Time.utc(2017, 1, 1, 12, 0, 0)) do
      token = Firefighter::TokenGenerator.from_env.create_custom_token(uid, data: data)

      expect(token).to eql(custom_token_file)
    end
  end

  it "reads tokens" do
    Timecop.freeze(Time.utc(2017, 1, 1, 12, 0, 0)) do
      payload = Firefighter::TokenGenerator.from_env.read_token(custom_token_file)

      expect(payload['uid']).to eql(uid)
      expect(payload['data']).to eql(data)
    end
  end

  it "fetch_access_token" do
    VCR.use_cassette('fetch_access_token') do
      token = Firefighter::TokenGenerator.from_env.fetch_access_token
      expect(token).to eql(token_data)
    end
  end
end
