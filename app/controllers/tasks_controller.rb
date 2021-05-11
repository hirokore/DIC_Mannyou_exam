class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]
  before_action :irregul_operation, only: [ :show, :edit, :update, :destroy ]

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_path, notice: "登録完了"
    else
      render :new
    end
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集完了"
    else
      render :new
    end
  end

  def index
    @tasks = Task.where(user_id: current_user.id)
    @tasks = @tasks.page(params[:page]).per(8)
    if params[:sort_expired]
      @task_sort_created = @tasks.order(expired_at: :desc)
    elsif params[:sort_priority]
      @task_sort_created = @tasks.order(priority: :desc)
    elsif params[:search].present?
      if params[:search][:name].present? && params[:search][:status] != "---"
        @task_sort_created = @tasks.name_status_like(params[:search][:name],params[:search][:status])
      elsif params[:search][:name].present?
        @task_sort_created = @tasks.name_like(params[:search][:name])
      elsif params[:search][:status] != "---"
        @task_sort_created = @tasks.status_like(params[:search][:status])
      else
        @task_sort_created = @tasks
      end
    else
      @task_sort_created = @tasks.all.order(created_at: :desc)
    end
  end

  def show
  end

  def edit
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "削除完了"
  end

  private

  def task_params
    params.require(:task).permit(:name, :details, :expired_at, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def irregul_operation
    redirect_to tasks_path, notice: "不正操作を記録しました。" unless current_user.id == @task.user.id
  end
  
end
