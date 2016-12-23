class UsersController < ApplicationController
  before_action :logged_in_user, except: [:create, :new]
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

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @users = current_user.following.paginate page: params[:page],
    per_page: Settings.user_controller.per_page
    render "show_follow"
  end

  private
  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "do_not_find_user"
      redirect_to root_url
    end
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
    :password_confirmation
  end
end
