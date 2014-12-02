module Spree
  module AlipayHelper
    def link_to_partner_trade(payment_method)
      link_to image_tag('alipay.png', :alt=> I18n.t('spree.checkout.payment.alipay.partner_trade')), alipay_partner_trade_path(:payment_method_id => payment_method.id)
    end
  end

end
