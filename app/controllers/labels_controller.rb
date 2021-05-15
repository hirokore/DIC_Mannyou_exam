class LabelsController < ApplicationController
  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    @label.user_id = current_user.id
    if @label.save
      redirect_to user_path(current_user), notice: "登録完了"
    else
      render :new
    end
  end
  private

  def label_params
    params.require(:label).permit(:name)
  end

  def set_label
    @label = Label.find(params[:id])
  end

  def irregul_operation
    redirect_to labels_path, notice: "不正操作を記録しました。" unless current_user.id == @label.user.id
  end

end
