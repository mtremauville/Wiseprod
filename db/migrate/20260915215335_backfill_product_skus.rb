class BackfillProductSkus < ActiveRecord::Migration[8.1]
  class Product < ActiveRecord::Base; end

  def up
    Product.where(sku: nil).find_each do |product|
      loop do
        candidate = rand(1_000_000..9_999_999).to_s
        next if Product.exists?(sku: candidate)

        product.update_column(:sku, candidate)
        break
      end
    end
  end

  def down
    # Irreversible data backfill.
  end
end
