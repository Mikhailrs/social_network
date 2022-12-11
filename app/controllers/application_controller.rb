class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      flash[:alert] = 'Войдите в аккаунт'
      render 'users/unauthorized_unforbidden', status: :unauthorized
    end
  end
end
