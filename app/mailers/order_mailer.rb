class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.user_order_email.subject
  #
  def user_order_email(order_id, email, name)
    @name = name
    @email = email
    @order = Order.find_by_id(order_id)

    mail to: @email
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.ware_house_order_email.subject
  #
  def ware_house_order_email(order_id, email, name)
    @name = name
    @email = email
    @order = Order.find_by_id(order_id)

    mail to: @email
  end
end
