class UsersController < ApplicationController
  before_action :find_user, only: [:show, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 15)
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user

      redirect_to user_path(@user), notice: 'Аккаунт создан'
    else
      render 'new'
    end
  end

  def show
    @microposts = @user.wall.microposts.sorted.paginate(page: params[:page], per_page: 15)
  end

  def edit
  end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to user_path(@user), notice: 'Аккаунт изменен'
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy

    redirect_to users_path, notice: 'Аккаунт удален'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_path unless @user == current_user
  end

  def find_user
    @user = User.find(params[:id])
  end
end
