class Calculator::QuantityBucket < Calculator::Advanced
  def self.description
    I18n.t("quantity_bucket")
  end

  # as object we always get line items, as calculable we have Coupon, ShippingMethod or ShippingRate
  def compute(object)
    case object
    when Array
      total_quantity = object.map(:quantity).sum
    when Order
      total_quantity = object.line_items.sum('quantity')
    end

    get_shipping_rate(total_quantity) || self.preferred_default_amount
  end
end