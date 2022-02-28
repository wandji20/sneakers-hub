require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_many(:order_items) }
  it { should accept_nested_attributes_for(:order_items) }
end
