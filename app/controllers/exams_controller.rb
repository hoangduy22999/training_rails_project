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
            @search_results_exams = Exam.search_by_name(params[:search])
            if params[:time]
                time = params[:time].to_i
                @search_results_exams = time <= 60 ? @search_results_exams.search_lt_time(time):
                                                    @search_results_exams.search_gt_time(time)
                # @search_results_exams = @search_results_exams.search_lt_time(params[:time].to_i) if params[:time].to_i <= 60
                # @search_results_exams = @search_results_exams.search_gt_time(params[:time].to_i) if params[:time].to_i > 60
            end
            respond_to do |format|
                format.html {}
                format.js {}
            end
        else
            @search_results_exams = Exam.all
        end
    end

    def show
        @search_results_exams = Exam.all
    end
end
