RSpec.describe Firefighter::RealtimeDatabase do
  let(:firebase_token) { 'OEfCdregHGY86CYimTpCagwvvNj2' }
  let(:data) { {'some' => 'data'} }
  let(:write_data) { {"some" => "data" } }
  let(:add_data) { [{"name"=>"-LHDoyHSUmgxpxJNUmfy"}, {"name"=>"-LHDoyQINLCrTbfy2hI4"}, {"name"=>"-LHDoyZ9a1gouN_tAk7R"}] }

  it "writes data" do
    VCR.use_cassette('write') do
      updated_data = Firefighter::RealtimeDatabase.from_env.write("some-test/write/#{firebase_token}", data)
      expect(updated_data).to eql(data)
    end
  end

  it "reads data" do
    VCR.use_cassette('read') do
      data = Firefighter::RealtimeDatabase.from_env.read("some-test/write/#{firebase_token}")
      expect(data).to eql(write_data)
    end
  end

  it "adds data" do
    VCR.use_cassette('add') do
      updated_data = []
      updated_data << Firefighter::RealtimeDatabase.from_env.add("some-test/add/#{firebase_token}", data)
      updated_data << Firefighter::RealtimeDatabase.from_env.add("some-test/add/#{firebase_token}", data)
      updated_data << Firefighter::RealtimeDatabase.from_env.add("some-test/add/#{firebase_token}", data)
      expect(updated_data).to eql(add_data)
    end
  end
end
