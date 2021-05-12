class SessionsController < ApplicationController
  before_action :require_login, only: [:create, :new]
  def new
  end

  def profile
    redirect_to login_path if !is_logged_in?
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash[:success] = "Welcom to Exam App!"
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to root_path
    else
      flash[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end
  private
    def require_login
      if is_logged_in?
          flash[:error] = "You are logged"
          redirect_to root_path
      end
    end
end
