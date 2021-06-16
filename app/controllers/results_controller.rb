# frozen_string_literal: false

# application controller
class ResultsController < ApplicationController
  MAX_POINTS = 100

  def create
    @result = current_user.results.new(result_params)
    @result.assign_attributes(value: parse_result)
    return unless @result.save!

    @exam = @result.exam
    @questions = @exam.questions.includes(:answers)
    @user_answers = @result.user_answers
    @grade = @result.value
    redirect_to result_path @result
  end

  def show
    @result = params[:id] ? Result.find(params[:id]) : current_user.results.last
    @exam = @result.exam
    redirect_to :back if @exam.nil?
    @questions = @exam.questions.includes(:answers)
    @user_answers = @result.user_answers
    @grade = @result.value
  end

  def mysubmitted
    @results = Result.my_results(current_user).order(created_at: :desc).page(params[:page]).per(8)
  end

  def top
    @results = Result.top.page(params[:page]).per(8)
  end

  def destroy
    result = Result.find(params[:format])
    authorize! :destroy, result
    result.destroy! ? flash[:success] = 'Delete Result Success!' : flash[:danger] = 'Delete Result Fails!'
    redirect_to mysubmitted_results_path
  end

  private

  def result_params
    params.require(:result).permit(:subject_id, :exam_id, :time,
                                  user_answers_attributes: %i[exam_question_id answer_id content correct])
  end

  def parse_result
    grade = 0
    @point_per_question = @result.exam.point_per_question(MAX_POINTS)
    @result.user_answers.each do |user_answer|
      answer = user_answer.answer
      question = answer.question
      if question.types == 1 && compare_answer(answer, user_answer)
        grade += @point_per_question
      elsif user_answer.correct
        grade += (@point_per_question * answer.percent_point) / 100
      end
    end
    grade
  end

  def compare_answer(answer, user_answer)
    answer.content.eql? user_answer.content
  end
end
