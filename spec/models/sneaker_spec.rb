require 'rails_helper'

RSpec.describe Sneaker, type: :model do
  it { should have_many(:order_items) }
  it { should belong_to(:brand) }
  it { should belong_to(:gender) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
end
