require 'spec_helper'

describe Spree::AlipayController do

  # Regression tests for #55
  context "when current_order is nil" do
    before do
      controller.stub :current_order => nil
      controller.stub :current_spree_user => nil
    end

    context "partner_trade" do
      it "raises ActiveRecord::RecordNotFound" do
        expect(lambda { get :partner_trade, :use_route => :spree }).
          to raise_error(ActiveRecord::RecordNotFound)
      end
    end


  end
end