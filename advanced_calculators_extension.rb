class AdvancedCalculatorsExtension < Spree::Extension
  version "1.0"
  description "Set of advanced calculators"
  url "http://github.com/swistak/spree-advanced-calculators/tree/master"

  def activate

    # Add your extension tab to the admin.
    # Requires that you have defined an admin controller:
    # app/controllers/admin/yourextension_controller
    # and that you mapped your admin in config/routes

    Admin::ConfigurationsController.class_eval do
      before_filter :add_bucket_rates_links, :only => :index
      def add_bucket_rates_links
        @extension_links << {
          :link => admin_bucket_rates_path,
          :link_text => t('bucket_rates'),
          :description => t('bucket_rates_description')
        }
      end
    end

    [
      Calculator::PriceBucket, 
      Calculator::WeightBucket, 
      Calculator::QuantityBucket
    ].each(&:register)
  end
end
