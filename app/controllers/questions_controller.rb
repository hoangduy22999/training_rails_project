class QuestionsController < ApplicationController

    def index
    end

    def new
        @question = Question.new
    end
    
    def create
        @params = answer_params
        render 'show'
        # @params.each do |param|
        #     # @answer = @answer.create(content: "param[:content]", correct "param[:correct]")
        #     # if @answer.save
        #     #     flash[:message] = "Create Answer Sucess"
        #     #     render 'new'
        #     # else
        #     #     flash[:warning] = "Create Answer Fails"
        #     #     render 'new'
        #     # end
        # end
        # @question = Question.create(question_params)
        # # if @question.save
        # #     flash[:message] = "create success"
        # #     render 'new'
        # # else
        # #     flash[:warning] = "Create Fails"
        # #     render 'new'
        # # end
    end

    private
        def question_params
            params.require(:question).permit(:content, :subjects_id, :question_types_id)
        end

        def answer_params
            params.require(:answers)
        end
end
