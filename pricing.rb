class Discount
  @@discounts = {15 => 0.75, 25 => 0.775, 50 => 0.8, 75 => 0.825, 100 => 0.85, 200 => 0.875, 400 => 0.9, 600 => 0.925}
  @@discount_categories = {"high" => 1.1, "low" => 0.9}

  def self.get_discount(price_reference)
    @@discounts.each do |key, value|
      if price_reference < key
        return value
      end
    end
    return 0.95
  end

  def self.get_discount_category(brand_rating)
    return @@discount_categories[brand_rating] || 1
  end
end

class Price
  attr_accessor :brand_rating, :price_reference, :shipping_cost

  def initialize(**opts)
    @brand_rating, @price_reference, @shipping_cost = opts.values_at(:brand_rating, :price_reference, :shipping_cost)
    validate!
    set_pricing()
  end

  def validate!
    raise 'Missing brand_rating' if brand_rating.nil?
    raise 'Missing price_reference' if price_reference.nil?
    raise 'Missing shipping_cost' if shipping_cost.nil?
  end

  def set_pricing
    @price = (@price_reference - @shipping_cost * Discount.get_discount(@price_reference)) * Discount.get_discount_category(@brand_rating)
  end

  def get_pricing
    return @price
  end
end


price = Price.new(:brand_rating => brand.rating, :price_reference => price_reference, :shipping_cost => product_database.shipping_cost)
price_original = price.get_pricing()

