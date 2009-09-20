class Admin::BucketRatesController < Admin::BaseController
  resource_controller
  before_filter :load_data
  layout 'admin'

  update.response do |wants|
    wants.html { redirect_to collection_url }
  end

  create.response do |wants|
    wants.html { 
      if params["create_another"]
        rate = params["bucket_rate"].dup
        rate[:floor] = rate.delete(:ceiling)
        redirect_to new_object_url+"?"+({"bucket_rate" => rate}.to_param)
      else
        redirect_to collection_url 
      end
    }
  end
    
  private
  def collection
    @collection ||= end_of_association_chain.all(:order => 'calculator_id DESC, floor ASC')
  end
	
  def load_data
    @available_calculators = Calculator.find(
      :all,
      :conditions => {:advanced => true},
      :order => 'created_at DESC'
    )
  end
end
