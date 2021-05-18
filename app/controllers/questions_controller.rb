class QuestionsController < ApplicationController
    def index
        if params[:search]
            @search_results_questions = Question.where('content LIKE ?', "%#{params[:search]}%")
            respond_to do |format|
                format.html {}
                format.js { render partial: '_search-results' }
            end
        else
            @question = Question.all()
        end
    end

    def new
        @question = Question.new
        @subjects = Subject.all()
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

        def permit_answer_choice(n)
            params[:question].require("answers-choice")["#{n}"].permit(:content, :correct)
        end

        def permit_answer_write
            params[:question].require("answers-write").permit(:content, :correct)
        end

        def params_length
            params.length
        end

end
