class ApplicationController < ActionController::Base
  include Pagy::Backend

  private

  def paginate(query)
    @pagy, records = pagy(query)
    records
  end
end
