class QuestionsController < ApplicationController
    before_action :require_admin_login, only: [:new, :create, :edit]
    def index
    end

    def new
        @question = Question.new
    end

    def edit
    end
    
    def create
        @question = Question.new(question_params)
        if @question.save
            answer_params.each do |answer|
                @answer = @question.answers.build(:content=>answer[0], :correct=>answer[1])
                if !@answer.save
                    flash[:warning] = "Create Answer Fails"
                    break
                    redirect_to question_create_path
                end
            end
            flash[:success] = "Create Question Success"
        else
            flash[:warning] = "Create Question Fails"
        end
        redirect_to question_create_path
    end

    private
        def question_params
            params.require(:question).permit(:content, :subject_id, :type_id)
        end

        def answer_params
            answers ||= []
            params.require(:answers).each do |answer|
                answers.push([answer[1][:content],answer[1][:correct]])
            end
            answers
        end

        def require_admin_login
            if is_admin?
                flash[:warning] = "You not a admin"
                redirect_to root_path
            end
        end
end
