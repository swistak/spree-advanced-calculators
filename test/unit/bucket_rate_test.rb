require 'test_helper'

class TestBucketRate < Test::Unit::TestCase
  context BucketRate do
    setup do
      @bucket_rate = BucketRate.new({
          :floor => 1,
          :ceiling => 10,
          :rate => 20,
        })
    end

    should "be creatable" do
      assert @bucket_rate.save
    end

    should "check if floor is lower or equal to ceiling" do
      @bucket_rate.ceiling = 0
      assert !@bucket_rate.valid?
    end
  end
end
