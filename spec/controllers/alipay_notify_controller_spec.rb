require 'spec_helper'

describe Spree::AlipayNotifyController do

  # Regression tests for #55
  context "not from alipay" do

    subject { post :notify_web, :use_route => :spree } 
    
    context "notify_web" do
      it "raises ActiveRecord::RecordNotFound" do
        subject
        response.body.should == "error"
      end
    end


  end
end