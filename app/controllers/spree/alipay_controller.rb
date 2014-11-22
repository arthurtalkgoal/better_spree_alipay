module Spree
  class AlipayController < StoreController
    ssl_allowed

    def partner_trade
      order = current_order || raise(ActiveRecord::RecordNotFound)
      #<Spree::Payment id: 20, amount: #<BigDecimal:ec45118,'0.378E3',9(18)>, order_id: 13, source_id: 5, source_type: "Spree::PaypalExpressCheckout", payment_method_id: 2, state: "completed", response_code: nil, avs_response: nil, created_at: "2014-10-10 08:58:04", updated_at: "2014-10-10 08:58:16", identifier: "UP6QYWER", cvv_response_code: nil, cvv_response_message: nil>
      payment = Spree::Payment.create({:order_id => order.id, :amount => order.amount,  :payment_method_id=> payment_method.id})
      payment.started_processing!
      partner_trade = payment_method.set_partner_trade( payment.identifier , order, spree.order_url(order) , notify_alipay_url, {:subject=> "#{current_store.name} ##{order.number}"})
      redirect_to partner_trade
      
      
    end


    
    private
  
    def payment_method
      Spree::PaymentMethod.find(params[:payment_method_id])
    end

    def provider
      payment_method.provider
    end
  end
end