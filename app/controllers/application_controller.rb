class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      redirect_to login_path, alert: 'Войдите в аккаунт'
    end
  end
end
