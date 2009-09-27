require 'test_helper'

class TestWeightBucketCalculator < Test::Unit::TestCase
  context Calculator::Advanced do
    setup do
      @order = Factory(:order)
      @calculator = Calculator::WeightBucket.create(
        :calculable => @order,
        :preferred_default_amount => 666
      )
    end

    should "Be advanced of course" do
      assert @calculator.advanced?
    end

    should "return preffered amount if no ranges are set" do
      assert_equal(666, @calculator.compute(@order).to_i)
    end

    should "return nil from get_rate if no rates can be found" do
      assert(!@calculator.get_rate(0))
    end

    context "with rates" do
      setup do
        3.times{ |x|
          BucketRate.create(
            :floor => x*100,
            :ceiling=> (x+1)*100,
            :rate => (x+1)*100,
            :calculator => @calculator
          )
        }
      end

      should "calculate 100 if empty order is passed" do
        assert_equal(100, @calculator.compute(@order).to_i)
      end

      should "calculate correctly based on order" do
        Factory(:line_item, :order => @order, :variant => Factory(:variant, :weight => 20), :quantity => 1)
        assert_equal(100, @calculator.compute(@order.reload).to_i)

        Factory(:line_item, :order => @order, :variant => Factory(:variant, :weight => 20), :quantity => 10)
        @order.reload.update_totals
        assert_equal(300, @calculator.compute(@order).to_i)
      end

      should "calculate based on array of line_items" do
        lis = [
          Factory(:line_item, :order => @order, :variant => Factory(:variant, :weight => 20), :quantity => 1),
          Factory(:line_item, :order => @order, :variant => Factory(:variant, :weight => 20), :quantity => 10)
        ]
        assert_equal(300, @calculator.compute(lis).to_i)
      end
    end
  end
end
