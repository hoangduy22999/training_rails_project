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
        @subjects = Subject.all
        @question.answers.build
    end

    def edit
    end
    
    def create
        @params = question_params
        render 'show'

    end

    private
        def question_params
            params.require(:question).permit(:content, answers_attributes: [:content])
        end
end
