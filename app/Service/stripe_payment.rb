class StripePayment
  class << self
    def create_payment_intent(attrs)
      Stripe::PaymentIntent.create(attrs)
    rescue StandardError => e
      p e
      nil
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    def handle_webhook_response(event)
      return unless event.present?

      case event.type
      when 'payment_intent.payment_failed'
        payment_intent = event.data.object
        begin
          order = Order.find(payment_intent.metadata&.order_id&.to_i)
          order.incomplete!
        rescue StandardError => e
          p e
        end
      when 'payment_intent.succeeded'
        payment_intent = event.data.object
        begin
          order = Order.find(payment_intent.metadata&.order_id&.to_i)
          order.complete!
          # email user
          # broadcast update to empty shopping cart
        rescue StandardError => e
          p e
        end
      else
        puts "Unhandled event type: #{event.type}"
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  end
end
