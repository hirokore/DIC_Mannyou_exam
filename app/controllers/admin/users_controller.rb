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
    elsif @user.errors.any? 
      render :new
    else
      redirect_to admin_users_path, notice: "最後の管理者です、消せません"
    end
  end
  

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "削除完了"
    else
      redirect_to admin_users_path, notice: "最後の管理者です、消せません"
    end
  end
  
  
  private
  def admin_user
    redirect_to tasks_path, notice: "管理者以外はアクセスできません" unless current_user.admin?
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_params
    @user = User.find(params[:id])
  end
  
end
