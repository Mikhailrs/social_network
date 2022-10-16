module LikesHelper
  def likes(micropost)
    "\u{202F}#{micropost.likes_count}" if micropost.likes_count.positive?
  end
end
