class ExamsController < ApplicationController
    def new
        @exam = current_user.exams.new
        authorize! :create, @exam
        @questions = Question.limit(20).pluck(:content, :id)
        @subject = Subject.all.map{ |sb| [sb.name, sb.id]}
    end

    def create
        @exam = current_user.exams.new(name: params[:exam][:name], time: params[:exam][:time].to_i)
        authorize! :create, @exam
        question_id = params[:questions] 
        if @exam.save!
            @exam.questions << Question.find_by(id: question_id)
            flash[:success] = "Create Exam Success"
        else
            flash[:danger] = "Create Exam Fails"
        end
        redirect_to exams_path
    end

    def update
        @exam = Exam.find(params[:format])
        authorize! :create, @exam
        question_ids = params[:questions] 
        if @exam.update!(name: params[:exam][:name], time: params[:exam][:time].to_i)
            question_ids.each do |question_id|
                @exam.questions << Question.find(question_id) if !@exam.questions.find(question_id)
            end
            flash[:success] = "Update Exam Success"
            redirect_to exam_path
        else
            flash[:danger] = "Update Exam Fails"
            redirect_to exam_path(@exam)
        end
    end

    def search
        if params[:search] || params[:time] || params[:questions] || params[:subject]
            @exams = Exam.search_by_name(params[:search]).page(params[:page]).per(8)
            @exams = @exams.search_by_questions(params[:questions].to_i) if !params[:questions].blank?
            @exams = @exams.search_by_subject(params[:subject].to_i) if !params[:subject].blank?
            @exams = @exams.search_by_time(params[:time].to_i) if !params[:time].blank?
            respond_to do |format|
                format.html {}
                format.js {}
            end
        else
            @exams = Exam.page(params[:page]).per(10)
        end
    end

    def show
        @exams = Exam.all.page(params[:page]).per(10)
        if params[:format]
            @exams = @exams.search_by_subject(params[:format].to_i)
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

    def edit
        authorize! :update, @exam
        @subject = Subject.all.map{ |sb| [sb.name, sb.id]}
        if exam_id = params[:format].presence
            @exam = current_user.exams.find(exam_id)
            @questions = Question.limit(20).pluck(:content, :id)
        else
            @exams = current_user.exams.page(params[:page]).per(10)
        end
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
        @exam = current_user.exams.build(time: time, name: "Random (#{current_user.name})", subject_id: 1)
        authorize! :create, @exam
        if @exam.save!
            @exam.questions << @questions
            redirect_to exam_detail_path(@exam)
        else
            redirect_to root_path
            flash[:warning] = "Create Random Exam Fails"
        end

    end

    def destroy
        exam = Exam.find(params[:format])
        exam.destroy! ? flash[:success] = "Delete Exam Success" : flash[:danger] = "Delete Exam Fails"
        redirect_to exam_path 
    end

    private
        def get_or_random(params, random)
            params = params.to_i
            params = random.sample if params == 0
            params
        end
end
