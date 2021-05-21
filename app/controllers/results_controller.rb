class ResultsController < ApplicationController
  MAX_POINTS = 100

  def create
    result = Result.last
    @questions = result.exam.questions    
    @grade = get_result(result)
  end
  
  def show
    @result = params[:format] ? Result.find[params[:format]] : current_user.results.last
    @exam = @result.exam
    @questions = @exam.questions
    @user_answers = @result.user_answers
    render 'create'
  end

  private
    def result_params
      params.require(:result).permit(:subject_id, :exam_id, :user_id, 
                                      user_answers_attributes: [:exam_question_id, :answers_id, :content, :correct])
    end

    def is_correct_write(user_answer)
      user_answer.content.eql? ExamQuestion.by_user_answer(user_answer).first.question.answers.first.content
    end

    def is_correct_choice(user_answer)
      user_answer.correct == Answer.by_user_answer(user_answer).first.correct
    end

    def get_question_type(user_answer)
      ExamQuestion.find(user_answer.exam_question_id).question.type_id
    end

    def get_result(result)
      grade = 0
      number_questions = result.exam.questions.count
      point = MAX_POINTS / number_questions

      result.exam.questions.each do |question|
        if question.type_id == 2
          user_answer = get_answers(result, question).first
          grade += point if is_correct_write(user_answer)
        else
          number_choice_correct = question.answers.is_correct.count
          point_per_choice = point / number_choice_correct
          user_answers = get_answers(result,question).is_correct
          user_answers.each do |user_answer|
            grade += point_per_choice if is_correct_choice(user_answer)
          end
        end
      end
      grade
    end

    def get_answers(result, question)
      exam_question_id = ExamQuestion.by_exam_id(result.exam.id).by_question_id(question.id).first.id
      result.user_answers.where(exam_question_id: exam_question_id)
    end


  end
