class Calculator::PriceBucket < Calculator::Advanced
  def self.description
    I18n.t("price_bucket", :scope => :calculator)
  end

  def self.unit
    I18n.t(:'number.currency.format.unit')
  end

  # as object we always get line items, as calculable we have Coupon, ShippingMethod or ShippingRate
  def compute(order_or_line_items)
    if order_or_line_items.is_a?(Array)
      item_total = order_or_line_items.map(&:amount).sum
    else
      item_total = order_or_line_items.item_total
    end
    get_rate(item_total) || self.preferred_default_amount
  end
end