require 'rails_helper'

RSpec.describe User, type: :model do
  let(:subject) { create(:user) }
  it { should have_many(:orders) }
  it { should have_one(:shopping_cart) }
  it { should validate_presence_of(:email) }
  it 'validate uniqueness of email' do
    user = User.new(email: subject.email.upcase, password: '111111')
    expect(user.valid?).to_not be(true)
  end
  it { should validate_length_of(:email).is_at_least(4).is_at_most(50) }
end
