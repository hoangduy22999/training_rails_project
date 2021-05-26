class ExamsController < ApplicationController
    def new
        @exam = current_user.exams.new
        @search_results_questions = Question.all
    end

    def create
        @params = params
    end

    def search
        if params[:search] || params[:time]
            @search_result_exams = Exam.search_by_name(params[:search]).page(params[:page]).per(8)
            if !params[:time].blank?
                time = params[:time].to_i * 60
                @search_result_exams = @search_result_exams.search_by_time(time)
            end
            if !params[:questions].blank?
                questions = params[:questions].to_i
                @search_result_exams = @search_result_exams.search_by_questions(questions)
            end

            respond_to do |format|
                format.html {}
                format.js {}
            end
        else
            @search_result_exams = Exam.all.page(params[:page]).per(10)
        end
    end

    def show
        @search_result_exams = Exam.all.page(params[:page]).per(10)
    end
    
    def detail
        @exam = Exam.find(params[:format])
        @questions = @exam.questions
    end

    def submit
        @exam = Exam.find(params[:format])
        @questions = @exam.questions
        @result = Result.new
        @result.user_answers.build
    end
end
