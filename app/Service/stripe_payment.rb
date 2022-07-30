class StripePayment
  class << self
    def create_payment_intent(attrs)
      intent = begin
        Stripe::PaymentIntent.create(attrs)
      rescue => exception
        p exception
        nil
      end
      intent
    end

    def handle_webhook_response(event)
      return unless event.present?
      case event.type
      when 'payment_intent.payment_failed'
        payment_intent = event.data.object
        begin
          order = Order.find(payment_intent.metadata&.order_id&.to_i)
          order.incomplete!
        rescue => exception
          p exception
        end
      when 'payment_intent.succeeded'
        payment_intent = event.data.object
        begin
          order = Order.find(payment_intent.metadata&.order_id&.to_i)
          order.complete!
          # email user
          # broadcast update to empty shopping cart
        rescue => exception
          p exception
        end
      when 'payment_intent.created'
        payment_intent = event.data.object
        begin
          order = Order.find(payment_intent.metadata&.order_id&.to_i)
        rescue => exception
          
        end
      else
          puts "Unhandled event type: #{event.type}"
      end
    end
  end
end