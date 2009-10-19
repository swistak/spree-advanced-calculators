class Calculator::QuantityBucket < Calculator::Advanced
  def self.description
    I18n.t("quantity_bucket", :scope => :calculator_names)
  end

  def self.unit
    I18n.t(:qty)
  end

  # as object we always get line items, as calculable we have Coupon, ShippingMethod or ShippingRate
  def compute(order_or_line_items)
    case order_or_line_items
    when Array
      total_quantity = order_or_line_items.map(&:quantity).sum
    when Order
      total_quantity = order_or_line_items.line_items.sum('quantity')
    end

    get_rate(total_quantity) || self.preferred_default_amount
  end
end