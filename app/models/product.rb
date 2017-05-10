class Product < ApplicationRecord
  has_many :basket_products
  has_many :baskets, through: :basket_products

  validates :name, presence: true, uniqueness: true
  validates :price, :quantity, numericality: { greater_than_or_equal_to: 0 }, presence: true

  scope :available, -> { where(available: true) }

  def unavailable!
    update(available: false)
  end
end
