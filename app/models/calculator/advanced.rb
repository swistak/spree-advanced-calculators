class Calculator::Advanced < Calculator
  has_many :bucket_rates, :as => :calculator
  preference :default_amount, :decimal, :default => 0

  before_save :set_advanced

  def self.register
    super
    Coupon.register_calculator(self)
    ShippingMethod.register_calculator(self)
    ShippingRate.register_calculator(self)
  end

  def set_advanced
    self.advanced = true
  end

  def name
    calculable.respond_to?(:name) ? calculable.name : calculable.to_s
  end

  def unit
    self.class.unit
  end

  def get_rate(value)
    # First try to find where price falls within price floor and ceiling
    bucket = BucketRate.find(:first,
      :conditions => [
        "calculator_id = ? and floor <= ? and ceiling > ?",
        self.id, value, value
      ])

    if bucket
      return(bucket.rate)
    else
      # find largest one
      bucket = BucketRate.find(:last, :conditions => ['calculator_id = ?', self.id], :order => "ceiling DESC")
      # check if we've found largest one, and item_total is higher then ceiling
      if bucket && value > bucket.price_ceiling
        return(bucket.rate)
      else
        return(false) # if there's no rates, or we've hit a hole, let calculator use default rate.
      end
    end
  end
end
