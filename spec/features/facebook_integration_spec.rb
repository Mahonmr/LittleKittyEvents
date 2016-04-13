require 'rails_helper'

describe Users::OmniauthCallbacksController, :type => :controller do

  describe "user signing with facebook" do
    context "when facebook email doesn't exist in the system" do
      before(:each) do
        stub_env_for_omniauth
        get :facebook
        @user = User.where(:email => "ghost@nobody.com").first
      end

      it "After Signing in via Facebook, user shoule exist in app" do
        expect(@user).to_not eq(nil)
      end

      it "user should be signed in" do
        expect(subject.current_user).to_not eq(nil)
      end

      it "redirect athlete to root path after sighing in" do
        expect(response).to redirect_to('/home/athlete')
      end
    end

    context "sign in user with existing facebook credentials" do
      before(:each) do
        stub_env_for_omniauth
        @user = create(:user, :with_facebook)
        @user.update_attribute(:email, "ghost@nobody.com")
        get :facebook
      end

      it "After Signing in via Facebook, user shoule exist in app" do
        expect(@user).to_not eq(nil)
      end

      it "user should be signed in" do
        expect(subject.current_user).to_not eq(nil)
      end

      it "redirect athlete to root path after sighing in" do
        expect(response).to redirect_to('/home/athlete')
      end
    end
  end
end

def stub_env_for_omniauth
  request.env["devise.mapping"] = Devise.mappings[:user]
  env = { "omniauth.auth" => {"provider"=>"facebook",
   "uid"=>"10207201400451240",
   "info"=>{"email"=>"ghost@nobody.com", "name"=>"Mike Mahoney", "image"=>"http://graph.facebook.com/10207201400451240/picture"},
   "credentials"=>
    {"token"=>
      "CAAHbM0zGhkYBAAh9HFSAFk6fO5HfCMNc8lid5cvmB6E7FruBQEzFUiFwZA1wgKbAlJV0wSXJu4g8ZAwdHi94ZCUcmtp5ZByfduZAlu86AICj8ci1oFV8JqTdbxWDJqDcSpmSCdQ8INGZCVuwYgH5BJqM8wtKRtHsmqzLbGOxS4Dp2bObZA6yIPfQ7l4GVdkb4cwDNFWz87yQgZDZD",
     "expires_at"=>1465743999,
     "expires"=>true},
   "extra"=>{"raw_info"=>{"name"=>"Mike Mahoney", "email"=>"ghost@nobody.com", "id"=>"10207201400451240"}}}}
  request.env["omniauth.auth"] = env["omniauth.auth"]
end











# {"provider"=>"facebook",
#  "uid"=>"10207201400451240",
#  "info"=>{"email"=>"mahonmr@me.com", "name"=>"Mike Mahoney", "image"=>"http://graph.facebook.com/10207201400451240/picture"},
#  "credentials"=>
#   {"token"=>
#     "CAAHbM0zGhkYBAAh9HFSAFk6fO5HfCMNc8lid5cvmB6E7FruBQEzFUiFwZA1wgKbAlJV0wSXJu4g8ZAwdHi94ZCUcmtp5ZByfduZAlu86AICj8ci1oFV8JqTdbxWDJqDcSpmSCdQ8INGZCVuwYgH5BJqM8wtKRtHsmqzLbGOxS4Dp2bObZA6yIPfQ7l4GVdkb4cwDNFWz87yQgZDZD",
#    "expires_at"=>1465743999,
#    "expires"=>true},
#  "extra"=>{"raw_info"=>{"name"=>"Mike Mahoney", "email"=>"mahonmr@me.com", "id"=>"10207201400451240"}}}
