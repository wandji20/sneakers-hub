module ApplicationHelper
  include Pagy::Frontend
  def get_search_query(object)
    class_name = object.model_name
    param = class_name.to_s
    { param.downcase => object.name }
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id].downcase)
  end


  def logged_in?
    !current_user.nil?
  end

  def current_user
    if session[:user_id]
      User.find_by_id(session[:user_id])
    end
  end
end
