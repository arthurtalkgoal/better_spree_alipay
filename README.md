better_spree_alipay
===================

It is a wrapper for https://github.com/chloerei/alipay gem, using the https://github.com/spree/spree_gateway.

Notice that the Alipay only allow CNY(or RMB) payments. Therefore, your site should support CNY currency.

Installation
===================

1. Add this extension to your Gemfile with this line:

```ruby
gem 'spree_alipay_payment', github: 'arthurtalkgoal/better_spree_alipay'
```


2. Install the gem using Bundler:

```
bundle install
```


3  Copy & run migrations

```
bundle exec rails g spree_alipay_payment:install
```

4. Restart your server

If your server was running, restart it so that it can process properly.


Usage
===================

1. Use it as a normal Spree:Gateway

Add the AlipayXXX _(e.g. AlipayPartnerTrade) in Spree backend like normal payment. You need to input the _pid, _key, and _senderemail

2. Use it as a alipay button

```
<%=link_to_partner_trade(payment_method, @order, "My Order")%> 
```

** Notice that Refund flow is not implemented yet **

Contributing
===================

1. Currently only support Partner Trade, but the other methods are already supported in https://github.com/chloerei/alipay

Alipay::Service#create_partner_trade_by_buyer_url # 担保交易
Alipay::Service#trade_create_by_buyer_url         # 标准双接口
Alipay::Service#create_direct_pay_by_user_url     # 即时到帐


2. Bug report or pull request are welcome.


3. Make a pull request

Fork it

Create your feature branch (git checkout -b my-new-feature)

Commit your changes (git commit -am 'Add some feature')

Push to the branch (git push origin my-new-feature)

Create new Pull Request

Please write unit test with your code if necessary.
