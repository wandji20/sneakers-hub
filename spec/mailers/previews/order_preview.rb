# Preview all emails at http://localhost:3000/rails/mailers/order
class OrderPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order/user_order_email
  def user_order_email
    OrderMailer.user_order_email(1, 'user@email.com', 'Sugar')
  end

  # Preview this email at http://localhost:3000/rails/mailers/order/ware_house_order_email
  def ware_house_order_email
    OrderMailer.ware_house_order_email(1, 'user@email.com', 'Sugar')
  end

end
