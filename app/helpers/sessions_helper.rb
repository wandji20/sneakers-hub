module SessionsHelper
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.encrypted[:user_id]
      user = User.find_by(id: cookies.encrypted[:user_id])
      if user&.authenticate(cookies[:remember_token])
        log_in user
        @current_user ||= user
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
    session_cart = ShoppingCart.find_by_id(session[:shopping_cart_id])
    return unless session_cart.present?

    # Combine session cart with user cart
    combined_cart_items = (session_cart.order_items.or(user.shopping_cart.order_items)).select(
      'DISTINCT ON (order_items.sneaker_id) *'
    )

    user.shopping_cart.order_items = combined_cart_items
    user.shopping_cart.save
    session.delete(:shopping_cart_id)
    session_cart.destroy
  end
end
