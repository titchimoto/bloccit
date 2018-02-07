class SessionsController < ApplicationController

  def new

  end



  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      create_session(user)
      flash[:notice] = " Welcome back, #{user.name}!"
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email/password combo. Please try again."
      render :new
    end
  end



  def destroy
    destroy_session(current_user)
    flash[:notice] = "You've been succesfully logged out, see you soon!"
    redirect_to root_path
  end

end
