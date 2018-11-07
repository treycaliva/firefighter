RSpec.describe Firefighter::Identitytoolkit do
  let(:firebase_token) { 'OEfCdregHGY86CYimTpCagwvvNj2' }
  let(:signup_data) { {"email"=>"test@test.de", "expiresIn"=>"3600", "idToken"=>"eyJhbGciOiJSUzI1NiIsImtpZCI6ImZkZjY0MWJmNDY3MTA1YzMyYWRkMDI3MGIyZTEyZDJiZTJhYmNjY2IiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcnVieS1maXJlZmlnaHRlciIsImF1ZCI6InJ1YnktZmlyZWZpZ2h0ZXIiLCJhdXRoX3RpbWUiOjE1NDE1ODMwODQsInVzZXJfaWQiOiI3Uml2QUsyTzVSY0pJVmdwbEFpRjVXeGNkdnExIiwic3ViIjoiN1JpdkFLMk81UmNKSVZncGxBaUY1V3hjZHZxMSIsImlhdCI6MTU0MTU4MzA4NCwiZXhwIjoxNTQxNTg2Njg0LCJlbWFpbCI6InRlc3RAdGVzdC5kZSIsImVtYWlsX3ZlcmlmaWVkIjpmYWxzZSwiZmlyZWJhc2UiOnsiaWRlbnRpdGllcyI6eyJlbWFpbCI6WyJ0ZXN0QHRlc3QuZGUiXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.NuEa8g9JhtSev1-aDXIejYWwnshSBPW7RLdZXmrPs6Ni-1gVZAnRkW13bY1pSLr_3EgjZfsM-HZhM9K6wXItcfQfUxIUsUxGjWM8FSENNgjmYA2GmPx2c3n0W-vTPuVp7d33RcOXj1sVW1nVgjfvCmduS7Y_jstD9iDvot0ORD0dSR_bl5Q4-iCYQUM5HXH16Uhi0tNwop8IFEYm7XKDrlwr-xi8FjSvU4bBOOoNgakvfszW_BRIo-tVZvCJ66VRjvfz6aiP5I4ydxhqxfP2UIUacIeBiKzoBl4cxZw3u11l1pf_aWMCSIW_kzT6qQl7VSmgcCL5L8O9n_0XFMxVVw", "kind" => "identitytoolkit#SignupNewUserResponse", "localId" => "7RivAK2O5RcJIVgplAiF5Wxcdvq1", "refreshToken" => "AEXAG-cbmhwRJYY_2ON2B3QBCT4XnM-TStkFIbII8GkEnGF-lzeDsYSBemFmpQDWKwlTmKIK4jUWZHYsPGQDbD1DfrkAc8B8GI3WTIIJSbeIphj5mDba4mVA-8qwwOVXJP8i_5M9LG54M_9sZ6dgadRx7WWFEWqL4qqnVHT0EBTvIfpF3BNHG6RAr2v5CcTx5Q997djtFHAoUo7IYBLLZi746R9t2REnCg"} }

  it "signsup users" do
    VCR.use_cassette('signup') do
      data = Firefighter::Identitytoolkit.from_env.signup('test@test.de', 'totalgeheimespasswort')
      expect(data).to eql(signup_data)
    end
  end
end
