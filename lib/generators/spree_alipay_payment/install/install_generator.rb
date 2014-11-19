module SpreeAlipayPayment
  module Generators
    class InstallGenerator < Rails::Generators::Base

      
      def add_javascripts
        frontend_js_file = "app/assets/stylesheets/spree/frontend.js"
        
        if  File.exist?(frontend_js_file)
          append_file frontend_js_file, "//= require spree/frontend/spree_alipay_payment\n"
        end
      end

      def add_stylesheets
        frontend_css_file = "app/assets/stylesheets/spree/frontend.css"
        
        if  File.exist?(frontend_css_file)
          inject_into_file frontend_css_file, " *= require spree/frontend/spree_alipay_payment\n", :before => /\*\//, :verbose => true
          
        end
      end

     
    end
  end
end