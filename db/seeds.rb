# # This file should ensure the existence of records required to run the application in every environment (production,
# # development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Example:
# #
# #   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
# #     MovieGenre.find_or_create_by!(name: genre_name)
# #   end
# puts "Suppression des données existantes..."
# GeneratedContent.destroy_all
# Product.destroy_all
# User.destroy_all

# puts "Création du compte démo..."
# demo_user = User.create!(
#   email: "demo@wiseprod.fr",
#   password: "demopassword123"
# )

# puts "Création de produits..."
# categories = ["Audio", "Informatique", "Téléphonie", "Image & Son", "Gaming", "Électroménager"]

# 15.times do
#   Product.create!(
#     name: Faker::Commerce.product_name,
#     category: categories.sample,
#     price: Faker::Commerce.price(range: 20..500),
#     description: Faker::Lorem.paragraph(sentence_count: 3),
#     sales_argument: Faker::Lorem.sentence(word_count: 12)
#   )
# end

# puts "#{Product.count} produits créés."
# puts "Compte démo : demo@wiseprod.fr / demopassword123"
require "net/http"
require "json"

puts "Suppression des données existantes..."
GeneratedContent.destroy_all
Product.destroy_all
User.destroy_all

puts "Création du compte démo..."
demo_user = User.create!(
  email: "demo@wiseprod.fr",
  password: "demopassword123"
)

puts "Récupération de produits high-tech depuis DummyJSON..."
categories = ["smartphones", "laptops", "tablets"]

categories.each do |category|
  uri = URI("https://dummyjson.com/products/category/#{category}")
  response = Net::HTTP.get(uri)
  data = JSON.parse(response)

  data["products"].each do |item|
    Product.create!(
      name: item["title"],
      category: item["category"],
      price: item["price"],
      description: item["description"],
      sales_argument: "Note moyenne : #{item['rating']}/5 · Stock disponible : #{item['stock']} unités",
      image_url: item["thumbnail"]
    )
  end
end

puts "#{Product.count} produits créés depuis DummyJSON."
puts "Compte démo : demo@wiseprod.fr / demopassword123"
