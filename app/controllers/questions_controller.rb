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
<<<<<<< HEAD
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
=======
        if cannot? :create, @question
            @params = params
        end
        render 'show'
        # @question = Question.new(question_params)
        # if @question.save
        #     answer_params.each do |answer|
        #         @answer = @question.answers.build(:content=>answer[0], :correct=>answer[1])
        #         if !@answer.save
        #             flash[:warning] = "Create Answer Fails"
        #             break
        #             redirect_to question_create_path
        #         end
        #     end
        #     flash[:success] = "Create Question Success"
        # else
        #     flash[:warning] = "Create Question Fails"
        # end
        # redirect_to question_create_path
>>>>>>> ad5ece2465df8a0811eba7deb5fc727115b922af
    end

    private
        def question_params
            params.require(:question).permit(:content, :subject_id, :type_id)
        end

        def answer_type
            params[:question][:type_id]
        end
<<<<<<< HEAD

        def permit_answer_choice(n)
            params[:question].require("answers-choice")["#{n}"].permit(:content, :correct)
        end

        def permit_answer_write
            params[:question].require("answers-write").permit(:content, :correct)
        end

        def params_length
            params.length
        end

=======
>>>>>>> ad5ece2465df8a0811eba7deb5fc727115b922af
end
