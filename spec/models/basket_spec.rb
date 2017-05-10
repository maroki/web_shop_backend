require 'rails_helper'

RSpec.describe Basket, type: :model do
  describe "BasketProduct validation" do
    it "has valid factory" do
      basket = FactoryGirl.create(:basket)
      expect(basket).to be_valid
    end
  end
end
