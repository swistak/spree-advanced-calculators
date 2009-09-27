class BucketRate < ActiveRecord::Base
  belongs_to :calculator
  
  validates_presence_of :floor, :ceiling, :rate

  named_scope :order_by_floor, :order => "floor"
  named_scope :for_calculator, lambda{ |calc|
    if calc.is_a?(Calculator)
      {:conditions => {:calculator_id => calc.id}}
    else
      {:conditions => {:calculator_id => calc.to_i}}
    end
  }

  def unit
    calculator && calculator.unit
  end

  def validate
    if !ceiling.blank? && !floor.blank? && ceiling.to_i < floor.to_i
      errors.add(:ceiling, :higher_or_equal)
    end
  end
  
  def <=>(other)
    self.floor <=> other.floor
  end
end
