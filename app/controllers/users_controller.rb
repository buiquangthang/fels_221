class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]

  def new
    @user = User.new
  end

  def show
    @relationship = current_user.active_relationships.find_by followed_id:params[:id]
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "not_exist"
      redirect_to signup_path
    else
      @activities = @user.activities.order_by_date.paginate page: params[:page],
        per_page: Settings.user_controller.per_page
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "welcome"
      redirect_to @user
    else
      render :new
    end
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "do_not_find_user"
      redirect_to request.referer
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
    :password_confirmation
  end
end
