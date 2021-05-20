class ResultsController < ApplicationController
  def create
    @params = result_params
  end

  private
    def result_params
      params.require(:result).permit(:subject_id, :exam_id, :user_id, 
                                      user_answers_attributes: [:exam_questions_id, :answers_id, :content, :correct])
    end

    def question_write(user_answer)
      user_answer.content.eql? user_answer.question.answers.first.content
    end
end
