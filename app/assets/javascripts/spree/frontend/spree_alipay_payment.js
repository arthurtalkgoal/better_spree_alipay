//= require spree/frontend

SpreeAlipayPayment = {
  updateSaveAndContinueVisibility: function() {
    if (this.isButtonHidden()) {
      $(this).trigger('hideSaveAndContinue')
    } else {
      $(this).trigger('showSaveAndContinue')
    }
  },
  isButtonHidden: function () {
    paymentMethod = this.checkedPaymentMethod();
    return (!$('#use_existing_card_yes:checked').length && SpreeAlipayPayment.paymentMethodID && paymentMethod.val() == SpreeAlipayPayment.paymentMethodID);
  },
  checkedPaymentMethod: function() {
    return $('div[data-hook="checkout_payment_step"] input[type="radio"][name="order[payments_attributes][][payment_method_id]"]:checked');
  },
  hideSaveAndContinue: function() {
    $("#checkout_form_payment [data-hook=buttons]").addClass('hidden_button');
  },
  showSaveAndContinue: function() {
    $("#checkout_form_payment [data-hook=buttons]").removeClass('hidden_button');
  }
}

$(document).ready(function() {
  SpreeAlipayPayment.updateSaveAndContinueVisibility();
  paymentMethods = $('div[data-hook="checkout_payment_step"] input[type="radio"]').click(function (e) {
    SpreeAlipayPayment.updateSaveAndContinueVisibility();
  });
})