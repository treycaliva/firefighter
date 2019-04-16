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

  it "streams data" do
    begin
      WebMock.disable! # cannot use allow_web_connect! see https://github.com/httprb/http/issues/212

      client = Firefighter::RealtimeDatabase.from_env
      client.listen("some-test/write/") do |connection, event, path, data|
        expect(event).to eql("put")
        expect(path).to eql("/")
        expect(data).to eql(data)
        connection.close
      end
    ensure
      WebMock.enable!
    end
  end

  it "deletes data" do
    VCR.use_cassette('delete') do
      Firefighter::RealtimeDatabase.from_env.delete("some-test/write/#{firebase_token}")
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
