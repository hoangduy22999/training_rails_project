class QuestionsController < ApplicationController
    def index
    end

    def new
        @question = Question.new
    end

    def edit
    end
    
    def create
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
    end

    private
        def question_params
            params.require(:question).permit(:content, :subject_id, :type_id)
        end

        def answer_params
            type = params[:question][:type_id]
            answers ||= []
            answer_param = params[:question][:answers]
            if type == 1
                answer_param.each do |answer|
                    answers.push([answer[1][:content],answer[1][:correct]])
                end
            else
                answers.push([answer_param[:content],answer_param[:correct]])
            end
            answers
        end
end
