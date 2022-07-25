module ApplicationHelper
  include Pagy::Frontend

  def turbo_stream_target
    current_page?(sneakers_path) ? 'sneakers' : '_top'
  end
end
