module ApplicationHelper
  include Pagy::Frontend

  def turbo_stream_target
    current_page?(sneakers_path) || current_page?(root_path) ? 'sneakers' : '_top'
  end

  def stripe_key
    ENV['STRIPE_PUBLISHABLE_KEY'] || Rails.application.credentials.dig(:stripe, :stripe_publishable_key)
  end
end
