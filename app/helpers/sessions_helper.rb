module SessionsHelper
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.encrypted[:user_id]
      user = User.find_by(id: cookies.encrypted[:user_id])
      if user&.authenticate(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def login(user)
    session[:user_id] = user.id
  end

  def logged_in?
    !current_user.nil?
  end

  def logout
    forget(current_user)
    session.delete(:user_id)
    session.delete(:shopping_cart_id)
    @current_user = nil
  end

  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def save_url
    session[:previous_path] = request.original_fullpath
  end

  def redirect_location
    session[:previous_path] || root_path
  end

  def transfer_shopping_cart(user)
    return if user.shopping_cart

    user.shopping_cart = @shopping_cart
    session.delete(:shopping_cart_id)
  end

  def shopping_cart_items
    @shopping_cart.order_items.pluck(:sneaker_id, :quantity).map do |pair|
      { sneaker_id: pair[0], quantity: pair[1] }
    end
  end
end
