require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "BasketProduct validation" do
    it "has valid factory" do
      product = FactoryGirl.create(:product)
      expect(product).to be_valid
    end
  end
end
