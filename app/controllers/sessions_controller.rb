class SessionsController < ApplicationController

  # creating user with given auth info
  def create
    if auth_info
      user = User.from_omniauth(auth_info)
      session[:user_id] = user.id
    end
    render 'finish', layout: false
  end

  def destroy
    session[:user_id] = nil
    respond_to do |format|
      format.html { redirect_to root_url, notice: "Signed out." }
      format.json { head :ok }
    end
  end

  # json returned by '/me' route
  def show
    respond_to do |format|
      format.json do
        if current_user
          render json: current_user.to_json
        else
          # raise 401 error if not authorized
          render json: {message: 'You are not authorized.'}, status: :unauthorized
        end
      end
    end
  end

private

  # auth_info hash from omniauth
  def auth_info
    env["omniauth.auth"]
  end
end