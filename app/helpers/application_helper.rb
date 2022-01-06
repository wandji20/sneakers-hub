module ApplicationHelper
  include Pagy::Frontend
  def get_search_query(object)
    class_name = object.model_name
    param = class_name.to_s
    { param.downcase => object.name}
  end
end
