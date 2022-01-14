module Authenticate
  extend ActiveSupport::Concern

  def login(user)
    session[:user_id] = user.id
  end
  
end