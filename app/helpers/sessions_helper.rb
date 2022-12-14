module SessionsHelper

  def current_user
    @current_user ||= begin
      if session[:user_id]
        User.find_by(id: session[:user_id])
      elsif cookies.signed[:user_id]
        user = User.find_by(id: cookies.signed[:user_id])
        if user && user.authenticated?(cookies[:remember_token])
          log_in user
          user
        end
      end
    end
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def logged_in?
    current_user.present?
  end

  def forget(user)
    user.forget
    cookies.delete([:user_id])
    cookies.delete([:remember_token])
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
  end
end
