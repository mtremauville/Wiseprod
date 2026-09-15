class Receipt < ApplicationRecord
  belongs_to :customer
  has_many :receipt_items, dependent: :destroy

  VAT_RATE = 0.20

  before_validation :generate_ticket_number, on: :create

  def self.build_from_cart(items, customer)
    total_ttc = items.sum do |item|
      item_total = item[:product].price
      item_total += item[:services].sum { |s| 0 } # services : prix à définir si besoin, actuellement inclus sans surcoût affiché séparément
      item_total
    end

    receipt = new(
      customer: customer,
      total_ttc: total_ttc,
      total_ht: (total_ttc / (1 + VAT_RATE)).round(2),
      finalized_at: Time.current
    )

    items.each do |item|
      receipt.receipt_items.build(
        sku: item[:product].sku,
        name: item[:product].name,
        quantity: 1,
        unit_price: item[:product].price
      )
      item[:services].each do |service|
        receipt.receipt_items.build(
          sku: service[:sku],
          name: service[:name],
          quantity: 1,
          unit_price: 0
        )
      end
    end

    receipt
  end

  private

  def generate_ticket_number
    loop do
      self.ticket_number = "T#{Time.current.strftime('%y%m%d')}-#{rand(1000..9999)}"
      break unless Receipt.exists?(ticket_number: ticket_number)
    end
  end
end
