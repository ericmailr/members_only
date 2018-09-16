module SessionsHelper

  def sign_in(user)
    token = User.new_token
    cookies.permanent[:remember_token] = token
    user.remember(token)
    set_current_user(user)
  end

  def sign_out
    @current_user = get_current_user
    @current_user.forget
    cookies.delete(:remember_token)
    @current_user = nil
  end

  def get_current_user
    remember_digest = User.digest(cookies[:remember_token])
    @current_user ||= User.find_by(remember_digest: remember_digest)
  end

  def set_current_user(user)
    @current_user = user
  end

  def signed_in?
    !get_current_user.nil?
  end

end
