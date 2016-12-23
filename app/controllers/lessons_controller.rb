class LessonsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :correct_user, only: :show
  
  def index
    @lessons = current_user.lessons.of_category(params[:category_id])
  end

  def show
    @results = @lesson.learns.paginate(page: params[:page])
      .per_page Settings.lessons_controller.per_page
  end

  def new
    category = Category.find_by id: params[:category_id]
    learned_ids = Learn.learned_ids current_user.id, category
    if learned_ids.empty?
      questions = category.questions.take Settings.lessons_controller.get
    else
      questions = category.questions.question_not_learn(learned_ids)
        .take Settings.lessons_controller.get
    end
    @lesson = category.lessons.build
    questions.each do |question|
      @lesson.learns.build question_id: question.id
    end
  end

  def create
    @lesson = current_user.lessons.build lesson_params
    @lesson.category_id = params[:category_id]
    @lesson.learns.each do |learn|
      learn.is_correct = Learn.check_correct_answer(learn.answer_id)
    end
    if @lesson.save
      score = @lesson.learns.is_correct.count
      @lesson.update score: score
      redirect_to category_lesson_path @lesson.category, @lesson
    else
      flash[:danger] = t "not_save_lesson"
      render :new
    end
  end

  private
  
  def lesson_params
    params.require(:lesson).permit(learns_attributes: [:question_id, :answer_id])
  end

  def correct_user
    @lesson = Lesson.find_by id: params[:id]
    redirect_to root_url unless current_user.lessons.exists? @lesson
  end
end
