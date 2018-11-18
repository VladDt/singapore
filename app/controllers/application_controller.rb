class ApplicationController < ActionController::API

  include ActionController::Cookies


  def require_auth
    (redirect_to '/login', status: 401, message: 'You must be logged in to access the requested page!') if !logged_in?
  end

  def user_deleted?
    @user.deleted
  end

  def set_no_browser_cache
    response.headers["Last-Modified"] = Time.now.httpdate
    response.headers["Pragma"] = "no-cache"
    response.headers["Cache-Control"] = 'no-store, no-cache, must-revalidate, max-age=0, pre-check=0, post-check=0'
  end

  def log_in(user)
    if user.deleted
      redirect_to '/signup', status: 404, message: "User doesn't exist. Please sign up!"
    else
      session[:user_id] = user.id
      session[:key] = generate_key
    end
  end

  def log_out
    session.delete(:user_id)
    session.delete(:key)
    @current_user = nil
  end

  def generate_key
    Digest::SHA256.hexdigest([Time.now, rand].join)
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      @user = User.find_by(id: user_id)
      if @user && @user.sessions.find_by(key: cookies[:remember_token])
        log_in(@user)
        @current_user = @user
      end
    end
  end

  def logged_in?
    @current_user
  end


end
