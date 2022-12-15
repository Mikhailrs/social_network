class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :find_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @micropost = Micropost.create(body: microposts_params[:body],
                                  user_id: current_user.id,
                                  wall_id: @user.wall.id)

    redirect_to user_path(@user)
  end

  def destroy
    @micropost = Micropost.find(params[:id])
    @micropost.delete

    redirect_to user_path(@user)
  end

  private

  def microposts_params
    params.require(:microposts).permit(:body)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def correct_user
    @user = User.find_by(id: params[:user_id])
    render file: "#{Rails.root}/public/403.html", status: :forbidden unless @user == current_user
  end
end
