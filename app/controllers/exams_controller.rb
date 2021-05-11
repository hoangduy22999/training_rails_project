class ExamsController < ApplicationController
    def new
        @exam = current_user.exams.new
    end

    def create
        @params = params
        flash[:message] = "Create question success"
        render 'news'
    end

    def group
        @exams = Exam.where(subject_id: :format)
    end
end
