class SessionsController < ApplicationController
  def create     
    auth = request.env["omniauth.auth"] 
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth) 

    #render json: { token: auth["credentials"]["token"] }
    # auth = request.env["omniauth.auth"]     
    # user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)     
    session[:user_id] = user.id     
    redirect_to rails_path
    #render json: @current_user.name
  end
 
  def destroy
    session[:user_id] = nil
    redirect_to rails_path, :notice => "Signed out!"
  end

  def me
    render json: @current_user.name 
  end
end
