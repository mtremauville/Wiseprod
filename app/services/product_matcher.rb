class ProductMatcher
  MOBILITY_TO_CATEGORY = {
    "smartphone" => "smartphones",
    "tablette" => "tablets",
    "ordinateur" => "laptops"
  }.freeze

  BUDGET_RANGES = {
    "moins_300" => 0..300,
    "300_700" => 300..700,
    "700_1500" => 700..1500,
    "plus_1500" => 1500..100_000
  }.freeze

  def initialize(consultation)
    @consultation = consultation
  end

  def call
    category = MOBILITY_TO_CATEGORY[@consultation.mobility]
    range = BUDGET_RANGES[@consultation.budget_range]

    products = Product.where(category: category)
    products = products.where(price: range) if range

    products.limit(3)
  end
end
