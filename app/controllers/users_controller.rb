class UsersController < ApplicationController
  load_and_authorize_resource

  def destroy
    user = User.find(params[:format])
    authorize! :destroy, user
    if user.destroy!
      flash[:success] = 'Delete User Success!'
    else
      flash[:danger] = 'Delete User Fails!'
    end
    @users = User.user.page(params[:page]).per(10)
    redirect_to users_path
  end

  def show_all
    authorize! :destroy, @user
    if params[:format]
      @user = User.find(params[:format])
      @results = @user.results
      render 'detail'
    end
    @users = User.user.page(params[:page]).per(10)
  end
end
