class UpdateProductsFromApiService

  URL = 'https://ncakqcujsk.execute-api.ap-southeast-2.amazonaws.com/PKTechTest/products'
  JSON = '{"outletNumber":"2824497","plateNumber":"06V3311","vendorLocation1":"Westfield Parramatta, Level 2 Cntr Mgmnt","vendorLocation2":"Argyle Street, Parramatta","promoExpirySeconds":0,"isHappyHour":false,"products":[{"productCode":"953945","productPrice":"350","isAvailable":true,"displayOrder":100,"imageName":null,"packagingGroup":"600PETMTF","productName":"Mount Franklin ","volume":"600"},{"productCode":"957848","productPrice":"350","isAvailable":true,"displayOrder":301,"imageName":"https://www.vendswift.com.au/products/imagemunge.aspx?p=957848&size=500","packagingGroup":"450MFSPARK","productName":"MTF Light/Sparkling Lime ","volume":"450"},{"productCode":"955732","productPrice":"400","isAvailable":true,"displayOrder":500,"imageName":"https://www.vendswift.com.au/products/imagemunge.aspx?p=955732&size=500","packagingGroup":"600PETCARB","productName":"Coca-Cola ","volume":"600"},{"productCode":"953320","productPrice":"400","isAvailable":true,"displayOrder":501,"imageName":"https://www.vendswift.com.au/products/imagemunge.aspx?p=953320&size=500","packagingGroup":"600PETCARB","productName":"Coca-Cola No Sugar ","volume":"600"},{"productCode":"957343","productPrice":"400","isAvailable":true,"displayOrder":504,"imageName":"https://www.vendswift.com.au/products/imagemunge.aspx?p=957343&size=500","packagingGroup":"600PETCARB","productName":"Vanilla Coca-Cola ","volume":"600"},{"productCode":"955736","productPrice":"400","isAvailable":true,"displayOrder":750,"imageName":"https://www.vendswift.com.au/products/imagemunge.aspx?p=955736&size=500","packagingGroup":"600PETCARB","productName":"Sprite ","volume":"600"},{"productCode":"952352","productPrice":"430","isAvailable":true,"displayOrder":2501,"imageName":"https://www.vendswift.com.au/products/imagemunge.aspx?p=952352&size=500","packagingGroup":"500BARBROS","productName":"Barista Bros Iced Chocolate","volume":"500"},{"productCode":"952862","productPrice":"430","isAvailable":true,"displayOrder":2600,"imageName":"https://www.vendswift.com.au/products/imagemunge.aspx?p=952862&size=500","packagingGroup":"500CANCARB","productName":"Mother Original ","volume":"500"},{"productCode":"952732","productPrice":"430","isAvailable":true,"displayOrder":2815,"imageName":"https://www.vendswift.com.au/products/imagemunge.aspx?p=952732&size=500","packagingGroup":"500CANCARB","productName":"Monster Zero Ultra ","volume":"500"},{"productCode":"953922","productPrice":"430","isAvailable":true,"displayOrder":3001,"imageName":"https://www.vendswift.com.au/products/imagemunge.aspx?p=953922&size=500","packagingGroup":"600PETPADE","productName":"Powerade Mountain Blast ","volume":"600"}],"promotions":[{"promotionId":366,"promotionDescription":"Any 2 for $6","promoCost":"600","promoDiscount":"100","imageName":"http://www.vendswift.com.au/promoimages/imagemunge.aspx?p=SHOPMTFK2-4-6&size=500","promotionType":"BUNDLE","isHappyHour":false,"items1":["953945"],"items2":["953945"]},{"promotionId":367,"promotionDescription":"Any 2 for $6","promoCost":"600","promoDiscount":"200","imageName":"http://www.vendswift.com.au/promoimages/imagemunge.aspx?p=SHOPCSD2-4-6-19&size=500","promotionType":"BUNDLE","isHappyHour":false,"items1":["953320","955732","955736","957343"],"items2":["953320","955732","955736","957343"]}]}'

  def self.execute
    new.execute
  end

  def execute
    res = HTTParty.get URL

    if res.key? 'errorMessage'
      raise "Can you believe this endpoint returns 200 OK for both success and failure?"
    end

    vr = create_vending_machine(res)
    create_products(res['products'], vr)
    create_promotions(res['promotions'])
  end

  private 

  def create_vending_machine(attrs)
    vr = VendingMachine.find_or_initialize_by(outlet_number: attrs['outletNumber'])
    vr.plate_number = attrs['plate_number']
    vr.vendor_address = "#{attrs['vendorLocation1']}, #{attrs['vendorLocation2']}"
    vr.promo_expiry_seconds = attrs['promoExpirySeconds']
    vr.is_happy_hour = attrs['isHappyHour']

    vr.save!
    pp "Created vending machine"
    pp vr
    vr
  end

  def create_products(products_attrs, vending_machine)
    Product.destroy_all
    PackagingGroup.destroy_all

    products_attrs.each do |attr|
      product = Product.new
      product.id = attr['productCode']
      product.price = attr['productPrice']
      product.is_available = attr['isAvailable']
      product.display_order = attr['displayOrder']
      product.image_url = attr['imageName']
      product.name = attr['productName']
      product.volume = attr['volume']

      packaging_group = PackagingGroup.find_or_create_by!(code: attr['packagingGroup'])
      product.packaging_group = packaging_group
      product.vending_machine = vending_machine

      product.save!

      pp "Product created"
      pp product
    end
    
  end

  def create_promotions(promotions_attrs)
    Promotion.destroy_all
    ProductPromotion.destroy_all

    promotions_attrs.each do |attr|
      promotion = Promotion.new
      promotion.id = attr['promotionId']
      promotion.description = attr['promotionDescription']
      promotion.cost = attr['promoCost']
      promotion.discount = attr['promoDiscount']
      promotion.image_url = attr['imageName']
      promotion.promotion_type = attr['promotionType']
      promotion.is_happy_hour = attr['isHappyHour']
      promotion.save!
      pp "Promotion created"
      pp promotion

      bundle1_attrs = attr['items1'].map do |bundle_1_product_id|
        { bundle_number: 1,
          promotion_id: promotion.id,
          product_id: bundle_1_product_id }
      end

      bundle2_attrs = attr['items2'].map do |bundle_2_product_id|
        { bundle_number: 2,
          promotion_id: promotion.id,
          product_id: bundle_2_product_id }
      end
      
      ProductPromotion.create!(bundle1_attrs + bundle2_attrs)
    end
  end
end
