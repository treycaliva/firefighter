RSpec.describe Firefighter::TokenGenerator do
  let(:uid) { 'some-uid' }
  let(:data) { { 'fire' => 'hose' } }
  let(:file_token) { File.read('spec/support/files/jwt.example').chomp }

  it "generes proper tokens" do
    Timecop.freeze(Date.new(2017, 1, 1)) do
      token = Firefighter::TokenGenerator.from_env.create_token(uid, data: data)

      expect(file_token).to eql(token)
    end
  end

  it "reads tokens" do
    Timecop.freeze(Date.new(2017, 1, 1)) do
      payload = Firefighter::TokenGenerator.from_env.read_token(file_token)

      expect(payload['uid']).to eql(uid)
      expect(payload['data']).to eql(data)
    end
  end
end
