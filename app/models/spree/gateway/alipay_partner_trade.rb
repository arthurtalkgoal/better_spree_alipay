require 'alipay'

module Spree
  class Gateway::AlipayPartnerTrade < Gateway


    preference :pid, :string
    preference :key, :string
    preference :seller_email, :string
    
    
    
    def supports?(source)
      true
    end

    def provider_class
      ::Alipay::Service
    end

    def provider
      setup_alipay
      ::Alipay::Service
    end

    def auto_capture?
      true
    end
    
    def source_required?
      false
    end

    def method_type
      'alipay_partner_trade'
    end
    
    
    def purchase(money, source, gateway_options)
      nil
    end
    

    def set_partner_trade(out_trade_no, order, return_url, notify_url, gateway_options={})
      raise unless preferred_pid && preferred_key && preferred_seller_email
      amount = order.amount
      tax_adjustments = order.all_adjustments.tax.additional
      
      shipping_adjustments = order.all_adjustments.shipping
      
      adjustment_label = []
      adjustment_costs = 0.0
      
      order.all_adjustments.nonzero.eligible.each do |adjustment|
        next if (tax_adjustments + shipping_adjustments).include?(adjustment)
        adjustment_label << adjustment.label
      
        adjustment_costs += adjustment.amount # Spree::Currency.convert(adjustment.amount, order.currency, 'RMB')
      end
      
      subject = gateway_options[:subject] || order.number
      subject += " #{adjustment_label.join(' | ')}"if adjustment_label.present?
      shipping_cost = order.shipments.to_a.sum(&:cost)
      options = {
        :out_trade_no      => out_trade_no,         # 20130801000001
        :subject           => subject,   
        :logistics_type    => 'POST',   #EXPRESS、POST、EMS
        :logistics_fee     => shipping_cost,
        :logistics_payment => 'BUYER_PAY',
        :price             =>  amount,  
        :quantity          => 1,
        :discount          => adjustment_costs,
        :return_url        => return_url, # https://writings.io/orders/20130801000001
        :notify_url        => notify_url  # https://writings.io/orders/20130801000001/alipay_notify
      }

    
    
      return  provider.create_partner_trade_by_buyer_url(options)

    end

    
    

    # def refund(payment, amount)
    #   batch_no = Alipay::Utils.generate_batch_no # refund batch no, you SHOULD store it to db to avoid alipay duplicate refund
    #   options = {
    #       batch_no:   batch_no,
    #       data:       [{:trade_no => order.number, :amount => order.amount, :reason => 'WEBSITE_REFUND'}],
    #       notify_url: notify_url  # https://writings.io/orders/20130801000001/alipay_refund_notify
    #   }
    #   logger.info options
    #   refund_transaction = provider.create_refund_url(options)
    # end
    
    private
    
    def setup_alipay
      
      Alipay.pid = preferred_pid
      Alipay.key = preferred_key
      Alipay.seller_email = preferred_seller_email
    end
  end
end

#   payment.state = 'completed'
#   current_order.state = 'complete'