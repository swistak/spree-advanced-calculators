unless defined? SPREE_ROOT
  ENV["RAILS_ENV"] = "test"
  
  if ENV["SPREE_ENV_FILE"]
    require ENV["SPREE_ENV_FILE"]
  elsif File.dirname(__FILE__) =~ %r{vendor/SPREE/vendor/extensions}
    require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../../../")}/config/environment"
  else
    require "#{File.expand_path(File.dirname(__FILE__) + "/../../../../")}/config/environment"
  end
end

require File.join(SPREE_ROOT, "test/test_helper")
Dir[File.join(SPREE_ROOT, 'test/factories/*.rb')].each{|f| require(f)}
require "authlogic/test_case"
require 'shoulda'

class ActiveSupport::TestCase
  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false
end

ActionController::TestCase.class_eval do
  # special overload methods for "global"/nested params
  [ :get, :post, :put, :delete ].each do |overloaded_method|
    define_method overloaded_method do |*args|
      action,params,extras = *args
      super action, params || {}, *extras unless @params
      super action, @params.merge( params || {} ), *extras if @params
    end
  end
end

def setup
  super
  @params = {}
end
