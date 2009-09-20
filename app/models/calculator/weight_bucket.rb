class Calculator::WeightBucket < Calculator::Advanced
  def self.description
    I18n.t("weight_bucket")
  end

  # as order_or_line_items we always get line items, as calculable we have Coupon, ShippingMethod or ShippingRate
  def compute(order_or_line_items)
    case order_or_line_items
    when Order
      total_weight = order_or_line_items.line_items.sum('variants.weight', :include => :variant)
    when Array
      total_weight = order_or_line_items.map(&:weight).sum
    end

    get_shipping_rate(total_weight) || self.preferred_default_amount
  end
end
