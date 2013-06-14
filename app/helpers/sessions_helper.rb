module SessionsHelper
  def sign_in(user)
    #Under the hood, using permanent causes Rails to set the expiration to 20.years.from_now automatically.
    #Set a cookie that stores the rem token; use the rem token as uniq id
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
  end
  #how to do assignment outside of attr_accessible
  #   notice =
  def current_user=(user)
    @current_user = user
  end
  #how to get the current_user
  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
  end
  def current_user?(user)
    current_user == user
  end
  def signed_in_user
    unless signed_in?
      store_location
      # shortcut for setting flash[:notice] by passing an options hash to the redirect_to function.
      redirect_to signin_url, notice:  'Please sign in' unless signed_in?
    end
  end
  def signed_in?
    !current_user.nil?
  end
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  # put the current page url on the session
  def store_location
    session[:return_to] = request.url
  end

end
