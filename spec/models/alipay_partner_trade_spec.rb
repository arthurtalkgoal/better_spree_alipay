require 'spec_helper'

describe Spree::Gateway::AlipayPartnerTrade do
  
  
  before do
    Spree::Gateway.update_all(active: false)
    @gateway = described_class.create!(name: 'Alipay PartnerTrade', environment: 'sandbox', active: true)
    @gateway.set_preference(:pid, 'TESTPID')
    @gateway.set_preference(:key, 'TESTKEY')
    @gateway.set_preference(:seller_email, 'tester@testing.com')
    @gateway.save!

   
  end
  let(:payment) {create(:payment, order: order, payment_method: @gateway, amount: 10.00) }
  let(:country) {create(:country, name: 'United States', iso_name: 'UNITED STATES', iso3: 'USA', iso: 'US', numcode: 840)}
  let(:state) {create(:state, name: 'Maryland', abbr: 'MD', country: country)}
      
  let(:address) {create(:address,
        firstname: 'John',
        lastname:  'Doe',
        address1:  '1234 My Street',
        address2:  'Apt 1',
        city:      'Washington DC',
        zipcode:   '20123',
        phone:     '(555)555-5555',
        state:     state,
        country:   country
      )}

  let(:order) {create(:order_with_totals, bill_address: address, ship_address: address)}
      

  
  context '.provider_class' do
    it 'is a Alipay Service' do
      expect(@gateway.provider_class).to eq ::Alipay::Service
    end
  end
  
  context 'set_partner_trade' do
    it 'generate the partner trade button' do
      batch_no = Alipay::Utils.generate_batch_no
      expect(@gateway.set_partner_trade(batch_no, order, 'http://www.testing.com/return', 'http://www.testing.com/notify')).to include "alipay"
    end
  end
end