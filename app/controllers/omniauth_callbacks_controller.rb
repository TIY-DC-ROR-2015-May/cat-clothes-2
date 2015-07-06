class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    auth_data = request.env["omniauth.auth"]
    email = auth_data["info"]["email"]
    user = User.where(email: email).first_or_create! do |u|
      u.password = SecureRandom.hex 32
    end

    sign_in user
    redirect_to root_path, notice: "Signed in with Github"
  end
end