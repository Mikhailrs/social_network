class UsersController < ApplicationController

  def index
    @users = User.all
  end
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      redirect_to user_path(@user), notice: 'Аккаунт создан'
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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
end
