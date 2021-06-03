class ResultsController < ApplicationController
  MAX_POINTS = 100

  def create
    @result = current_user.results.new(result_params) 
    if @result.save!
      @result.update(:value=>get_result(@result))
    else
    end
  end

  def show
    if @result = params[:format] ? Result.find(params[:format]) : current_user.results.last
      @exam = @result.exam
      @questions = @exam.questions.includes(:answers)
      @user_answers = @result.user_answers
      @grade = @result.value
      render '_detail'
    else 
      redirect_to root_path
    end
  end
  
  def detail
    if @result = params[:format] ? Result.find(params[:format]) : current_user.results.last
      @exam = @result.exam
      redirect_to :back if @exam.nil?
      @questions = @exam.questions.includes(:answers)
      @user_answers = @result.user_answers
      @grade = @result.value
      respond_to do |format|
        format.html {}
        format.js {}
      end
    else
      redirect_to root_path
    end
  end

  def mysubmitted
    @results = Result.my_results(current_user).page(params[:page]).per(8)
  end

  def top
    @top_user = Result.top_user
    @my_result = Result.my_results(current_user).last(5)
  end


  private
    def result_params
      params.require(:result).permit(:subject_id, :exam_id, :time, 
                                      user_answers_attributes: [:exam_question_id, :answers_id, :content, :correct])
    end

    def is_correct_write(user_answer)
      user_answer.content.eql? ExamQuestion.by_user_answer(user_answer).first.question.answers.first.content
    end

    def is_correct_choice(user_answer)
      user_answer.correct == Answer.by_user_answer(user_answer).first.correct && user_answer.correct
    end

    def is_not_correct(user_answer)
      user_answer.correct && !Answer.by_user_answer(user_answer).first.correct
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
          choice_corrects = question.answers.is_correct.count 
          choice_not_corrects = question.answers.is_not_correct.count
          point_per_correct = choice_corrects == 0 ? 0 : point / choice_corrects
          point_per_not_correct = choice_not_corrects == 0 ? 0 : - point / choice_not_corrects
          point_for_question = 0
          user_answers = get_answers(result,question)
          user_answers.each do |user_answer|
            point_for_question +=  point_per_correct if is_correct_choice(user_answer)
            point_for_question += point_per_not_correct if is_not_correct(user_answer)
          end
          grade += point_for_question > 0 ? point_for_question : 0
        end
      end
      grade
    end

    def get_answers(result, question)
      exam_question_id = ExamQuestion.by_exam_id(result.exam.id).by_question_id(question.id).first.id
      result.user_answers.where(exam_question_id: exam_question_id)
    end


  end
