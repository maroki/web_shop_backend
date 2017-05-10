class Basket < ApplicationRecord
  has_many :basket_products, dependent: :destroy
  has_many :products, through: :basket_products

  accepts_nested_attributes_for :basket_products, allow_destroy: true

  before_save :set_full_price

  private

  def set_full_price
    self.full_price = basket_products.map { |b_p| b_p.quantity * b_p.product.price }.sum
  end
end
