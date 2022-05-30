class ProductPromotion < ApplicationRecord

  belongs_to :product
  belongs_to :promotion

  scope :type_1, -> { where(bundle_number: 1) }
  scope :type_2, -> { where(bundle_number: 2) }
end