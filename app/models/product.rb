class Product < ApplicationRecord
  has_many :generated_contents, dependent: :destroy
end
