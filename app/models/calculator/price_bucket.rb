class Calculator::PriceBucket < Calculator::Advanced
  def self.description
    I18n.t("price_bucket")
  end

  # as object we always get line items, as calculable we have Coupon, ShippingMethod or ShippingRate
  def compute(object)
    if object.is_a?(Array)
      item_total = object.map(:amount).sum
    else
      item_total = object.item_total
    end

    get_shipping_rate(item_total) || self.preferred_default_amount
  end
end