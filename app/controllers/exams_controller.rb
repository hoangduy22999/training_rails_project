class ExamsController < ApplicationController
    def new
        @exam = current_user.exams.new
        @questions = Question
    end

    def create
        @params = params
    end

    def group
        @exams = Exam.where(subject_id: :format)
    end
end
