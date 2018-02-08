module TopicsHelper

  def user_can_create_or_delete?
    current_user && current_user.admin?
  end

  def user_can_edit?
    current_user && (current_user.moderator? || current_user.admin?)
  end

end
