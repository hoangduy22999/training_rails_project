class ExamsController < ApplicationController
    before_action :require_admin_login, only: [:new, :create]

    def new
        @exam = current_user.exams.new
    end

    def create
        @params = params
        flash[:success] = "Create question success"
        render 'news'
    end

    def group
        @exams = Exam.where(subject_id: :format)
    end

    private
    def require_admin_login
        if is_admin?
            flash[:warning] = "You not a admin"
            redirect_to root_path
        end
    end
end
