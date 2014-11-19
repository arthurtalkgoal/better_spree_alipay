Spree::Core::Engine.add_routes do
  # Add your extension routes here
  #get '/alipay/confirm', :to => "alipay_notify#confirm", :as => :confirm_alipay
  get '/alipay/partner_trade', :to => "alipay#partner_trade", :as => :alipay_partner_trade
  post '/alipay/notify', :to => "alipay_notify#notify_web", :as => :notify_alipay
  
  
end
