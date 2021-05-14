module Admin::UsersHelper
  def admin?
    current_user.admin if logged_in?
  end
  def choose_admin_path
    if action_name == "new"
      admin_users_path
    elsif action_name == "edit"
      admin_user_path
    end
  end
end

