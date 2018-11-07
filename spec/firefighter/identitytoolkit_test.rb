RSpec.describe Firefighter::RealtimeDatabase do
  let(:firebase_token) { 'OEfCdregHGY86CYimTpCagwvvNj2' }
  let(:signup_data) { {'some' => 'data'} }

  it "signsup users" do
    VCR.use_cassette('signup') do
      data = Firefighter::Identitytoolkit.from_env.signup()
      expect(data).to eql(signup_data)
    end
  end
end
