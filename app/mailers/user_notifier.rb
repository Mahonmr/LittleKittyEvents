class UserNotifier < ActionMailer::Base
  default :from => 'Paws@LittleKittyEvents.com'

  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thank you for signing up to Little Kitty Events' )
  end
end
