class QuestionsController < ApplicationController
    def index
        if params[:search]
            @search_results_questions = Question.search_by_name(params[:search])
            respond_to do |format|
                format.html {}
                format.js {}
            end
        else
            @search_results_questions = Question.all
        end
    end

    def new
        @question = Question.new
        @subject = Subject.all.map{ |sb| [sb.name.capitalize, sb.id]  }
        @question.answers.build
    end

    def edit
    end
    
    def create
        @question = Question.new(question_params)
        if @question.save!

            flash[:success] = "Create Question Success!"
            redirect_to question_create_path
        else
            flash[:warning] = "Create Question Fails" 
            redirect_to question_create_path
        end
        @question = Question.new
        @subject = Subject.all.map{ |sb| [sb.name.capitalize, sb.id]  }
        @question.answers.build
    end

    private
        def question_params
            params.require(:question).permit(:content, answers_attributes: [:content, :correct])
        end
end
