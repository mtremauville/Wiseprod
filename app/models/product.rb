class Product < ApplicationRecord
  has_many :generated_contents, dependent: :destroy

  before_validation :generate_sku, on: :create

  private

  def generate_sku
    loop do
      self.sku = rand(1_000_000..9_999_999).to_s
      break unless Product.exists?(sku: sku)
    end
  end
end
