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

            if !params[:subject].blank?
                sb_id = params[:subject].to_i
                @search_result_exams = @search_result_exams.search_by_subject(sb_id)
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
        if params[:subject]
            @search_result_exams = @search_result_exams.search_by_subject(params[:subject])
        end
        @subject = Subject.all.map{ |sb| [sb.name.capitalize, sb.id]  }.unshift("")
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

    def random
        @subject = Subject.all.map{ |sb| [sb.name.capitalize, sb.id]  }.unshift(["Random",0])
    end

    def create_random
        time = get_or_random(params[:time], [15, 30, 45, 60, 90]) * 60
        questions = get_or_random(params[:question], [5, 10, 15])
        subject = params[:subject].to_i
        question_type = params[:question_type].to_i
        @questions = Question.all
        @questions = @questions.group_by_subject(subject) if subject != 0
        @questions = @questions.group_by_type(question_type) if question_type != 0
        @questions = @questions.order(Arel.sql('RANDOM()')).limit(questions)
        @exam = current_user.exams.build(time: time, name: "Random", subject_id: 1)
        if @exam.save!
            @exam.questions << @questions
            redirect_to exam_detail_path(@exam)
        else
            redirect_to root_path
            flash[:warning] = "Create Random Exam Fails"
        end
    end

    private
        def get_or_random(params, random)
            params = params.to_i
            params = random.sample if params == 0
            params
        end
end
