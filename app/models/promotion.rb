class Promotion < ApplicationRecord

  has_many :product_promotions_bundle_1, -> { type_1 }, class_name: 'ProductPromotion'
  has_many :products_bundle_1, through: :product_promotions_bundle_1
  
  has_many :product_promotions_bundle_2, -> { type_2 }, class_name: 'ProductPromotion'
  has_many :products_bundle_2, through: :product_promotions_bundle_2

  
end