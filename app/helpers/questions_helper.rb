module QuestionsHelper
    def question_type
        [["choice", 1],["write", 2]]
    end

    def exam_for_subject(id)
        @exam_for_subject = Exam.where(subject_id: :id)
    end

    def subjects
        subject = Subject.all
        sb = []
        subject.each do |s|
            sb.push([s.name, s.id])
        end
        sb
    end

    def question_group(id)
        @quetion = Question.where(:type_id=>id)
    end

    def question_count
        count = 0
    end

    def user_count
        a = User.where(admin_role: false).count
    end

    def fill_answer(answers)
        answers.each do |answer|            
        end
    end
end
