class QuestionsController < ApplicationController
    def index
        @search_results_questions = Question.all.search_by_name(params[:search]).page(params[:page]).per(8)
        @search_results_questions = @search_results_questions.group_by_subject(params[:subject].to_i) if !params[:subject].blank?
        @search_results_questions = @search_results_questions.group_by_type(params[:type].to_i) if !params[:type].blank?
        respond_to do |format|
            format.js {}
            format.html {}
        end
    end

    def new
        @question = Question.new
        authorize! :create, @question
        @subject = Subject.all.map{ |sb| [sb.name.capitalize, sb.id]  }
        @question.answers.build
    end

    def show
        @subject = Subject.all.map{ |sb| [sb.name.capitalize, sb.id]}
        if question_id = params[:format]
            @question = Question.find(question_id)
        else
            @questions = Question.all.page(params[:page]).per(10)
        end
    end
    
    def create
        @question = Question.new(question_params)
        authorize! :create, @exam
        if @question.save!
            flash[:success] = "Create Question Success!"
            redirect_to question_create_path
        else
            flash[:warning] = "Create Question Fails" 
            redirect_to question_create_path
        end
        @question = Question.new
        @subject = Subject.all.map{ |sb| [sb.name.capitalize, sb.id]  }
        @question.answers.build
    end

    def destroy
        question = Question.find(params[:format])
        authorize! :delete, @question
        if question.exams
            flash[:danger] = "Delete question fails"
        else
            question.destroy! ? flash[:success] = "Delete Question Success!" : flash[:danger] = "Delete Question Fails!"
        end
        redirect_to questions_path            
    end
    def update
        binding.pry
        @question = Question.find(params[:format])
        @question.update!(question_params) ? flash[:success] = "Update Question Success" : flash[:danger] = "Update Question Fails"
        redirect_to questions_path(@question)
    end

    def find_question
        authorize! :create, @exam
        if search_content = params[:search_content].presence
            results = Question.search_by_name(search_content).limit(20)
        elsif  selected_question_id = params[:selected_question_id].presence
            selected_question = Question.find_by(id: selected_question_id)
            results = Question.where.not(id: selected_question.id).take(19).unshift selected_question
        else
            results = Question.limit(20)
        end
        render json: { results: results.as_json(only: [:content, :id])}
    end

    private
        def question_params
            params.require(:question).permit(:content, :type_id, :subject_id, answers_attributes: [:content, :correct])
        end
end
