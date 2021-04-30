class TasksController < ApplicationController
  before_action :set_task, only: [ :show, :edit, :update, :destroy ]

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = Task.new(task_params)
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
    @task = Task.all
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
    params.require(:task).permit(:name, :detail)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
