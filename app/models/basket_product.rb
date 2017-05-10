class BasketProduct < ApplicationRecord
  belongs_to :basket, optional: true
  belongs_to :product

  validates :product_id, presence: true, uniqueness: { scope: :basket_id }
  validates :quantity, numericality: { greater_than: 0 }, presence: true

  validate :products_in_stock

  after_save :recalculate_products_in_stock

  private

  def products_in_stock
    return if changes['quantity'].blank?
    errors.add(:quantity, 'More than products on stock') unless new_quantity >= 0
  end

  def recalculate_products_in_stock
    return if changes['quantity'].blank?
    self.product.update(quantity: new_quantity)
  end

  def new_quantity
    product.quantity + (changes['quantity'][0] || 0) - changes['quantity'][1]
  end
end
