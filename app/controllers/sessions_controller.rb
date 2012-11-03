class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticcate(params[:session][:email],
                              params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid/email password combination."
      render 'new'
    else
      sing_in user
      redirect_to user
    end
  end

  def destroy
  end
end
