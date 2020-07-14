module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  # Remembers a user in a persistent session.
  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      return log_in user if user&.authenticated?(cookies[:remember_token])

    end
  end

  def logged_in?
    current_user.present?
  end

  # Forgets a persistent session.
  def forget user
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
  end
end
