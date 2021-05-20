module ExamsHelper
    def show_time_in_hour(minutes)
        minutes > 60 ? "#{minutes / 60}:#{minutes % 60}" : minutes
    end

    def get_exam_question_id(exam_id, question_id)
        ExamQuestion.by_exam_id(exam_id).by_question_id(question_id).first.id
    end
end
