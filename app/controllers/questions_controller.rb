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
    end

    def edit
    end
    
    def create
        @question = Question.create(question_params)
        if @question.save
            if answer_type == "2"
                @answer = @question.answers.build(permit_answer_write)
                @answer.save!
            else
                (0..3).each do |index|
                    @answer = @question.answers.build(permit_answer_choice(index))
                    @answer.save!
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

        def answer_type
            params[:question][:type_id]
        end
end
