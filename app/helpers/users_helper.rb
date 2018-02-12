module UsersHelper

  def user_has_zero_posts?(user)
    user.posts.count == 0
  end

  def user_has_zero_favorites?(user)
    user.favorites.count == 0
  end


end
