class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 15)
  end
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      log_in @user
      redirect_to user_path(@user), notice: 'Аккаунт создан'
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    @user.delete

    redirect_to users_path, notice: 'Аккаунт удален'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
  end

  def logged_in_user
    unless logged_in?
      redirect_to login_path, alert: 'Войдите в аккаунт'
    end
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_path unless @user == current_user
  end
end
