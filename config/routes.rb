define_routes do |map|
  map.namespace :admin do |admin|
    admin.resources :advanced_calculator_rates
  end
end