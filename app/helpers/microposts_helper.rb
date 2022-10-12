module MicropostsHelper
  def find_avatar_for_micropost(micropost)
    user = User.find(micropost.user_id)
    user.avatar
  end
end
