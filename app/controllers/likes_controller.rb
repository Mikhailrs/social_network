class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @micropost = Micropost.find(params[:micropost_id])

    @like = @micropost.likes.find_by(user_id: current_user.id)
    if @like.present?
      @like.destroy
    else

      @like = @micropost.likes.create(user_id: current_user.id)
    end

    render "create.js.erb"
  end
end
