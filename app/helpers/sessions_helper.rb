module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

    def current_user
        if (user_id = session[:user_id])
        @current_user ||= User.find_by(id: user_id)
        elsif (user_id = cookies.signed[:user_id])
        user = User.find_by(id: user_id)
            if user && user.authenticated?(cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end

    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

    def logged_in?
        !current_user.nil?
    end

    def is_logged_in?
        !session[:user_id].nil?
    end

    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
        flash[:sucess] = "Good bye!"
    end

    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end


    def subjects
        @subjects = Subject.all()
    end

    def exam_for_subject(id)
        @exam_for_subject = Exam.where(subject_id: :id)
    end

    def question_type
        [["choice", 1],["write", 2]]
    end

    def subjects
        subject = Subject.all
        sb = []
        subject.each do |s|
            sb.push([s.name, s.id])
        end
        sb
    end
end
