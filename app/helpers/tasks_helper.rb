module TasksHelper
  def choose_path
    if action_name == "new"
      tasks_path
    elsif action_name == "edit"
      task_path
    end
  end
  def choose_request
    if request.patch?
      'patch'
    elsif request.post?
      'post'
    end
  end
end
