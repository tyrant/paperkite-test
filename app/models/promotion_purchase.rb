class PromotionPurchase < Purchase

  belongs_to :promotion
  belongs_to :product_1
  belongs_to :product_2

  validate :promotion_bundle_1_includes_product_1
  validate :promotion_bundle_2_includes_product_2

  private

  def promotion_bundle_1_includes_product_1
    unless promotion.products_bundle_1.include? product_1
      errors.add :product_1, "#{product_1} must be a member of #{promotion.products_bundle_1}"
    end
  end

  def promotion_bundle_2_includes_product_2
    unless promotion.products_bundle_2.include? product_2
      errors.add :product_2, "#{product_2} must be a member of #{promotion.products_bundle_2}"
    end
  end
end