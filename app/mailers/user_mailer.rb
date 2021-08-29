class UserMailer < ApplicationMailer
  default from: "joe.mccann.dev@gmail.com"
  
  def welcome_email
    @user = params[:user]
    @user_url = user_url(@user)
    mail(
      to: email_address_with_name(@user.email, @user.name),
      subject: "Welcome to Private Events."
    )
  end
end
