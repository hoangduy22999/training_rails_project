class UsersController < ApplicationController
    before_action :require_login, only: [:show, :edit, :update]

    def profile
    end

    def new
        log_out if is_logged_in?
        @user = User.new
    end
    
    def edit
        @user = User.find(params[:id])
    end

    def update
    end

    def show
        if current_user
            if admin?(current_user)      
                @users = User.where(admin_role: "false") unless params[:format] 
            end
        end
    end

    def create
        @user = User.create(user_params)
        if @user.save
            flash[:success] = "Welcom to Exam App!"
            log_in @user
            redirect_to root_path
        else
            flash[:warning] = @user.errors.objects.first.full_message
            redirect_to new_users_path
        end
    end

    private
        def user_params
        params.require(:user).permit(:name, :email,:school_id, :gender, :age, :password, :password_confirmation)
        end
     
        def require_login
            unless is_logged_in?
                flash[:error] = "You must be logged in to access this section"
                redirect_to login_path
            end
        end

end
