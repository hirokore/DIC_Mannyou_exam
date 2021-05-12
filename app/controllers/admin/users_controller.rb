class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_params, only: [:show, :destroy, :update, :edit]

  def new
    @user = User.new
  end

  def index
    @users = User.all.order("created_at ASC")
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "作成完了"
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "更新完了"
    else
      render :new
    end
  end
  

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "削除完了"
  end
  
  
  private
  def admin_user
    redirect_to(tasks_path) unless current_user.admin?
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_params
    @user = User.find(params[:id])
  end
  
end
