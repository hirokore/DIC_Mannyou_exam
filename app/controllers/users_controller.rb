class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
    if logged_in?
      redirect_to tasks_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: "ユーザが作成されました！"
    else
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "投稿できました！"
    else
      render :edit
    end
  end

  def show
    @tasks = Task.where(user_id: current_user.id).includes(:user)
    @tasks = @tasks.page(params[:page]).per(8)
    @users = User.find(params[:id])
    unless current_user.admin?
      redirect_to tasks_path, notice: "不正操作を記録しました。" unless current_user.id == @users.id
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
