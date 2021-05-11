module Admin::UsersHelper
  def admin?
    current_user.admin if logged_in?
  end
end
