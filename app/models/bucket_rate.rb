class BucketRate < ActiveRecord::Base
  belongs_to :calculator
  
  validates_presence_of :floor, :ceiling, :rate

  named_scope :order_by_floor, :order => "floor"
  
  def <=>(other)
    self.floor <=> other.floor
  end
end
