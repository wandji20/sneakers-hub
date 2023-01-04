import { Controller } from "stimulus"
import {loadStripe} from '@stripe/stripe-js';

export default class extends Controller {
  static targets = ['errorMessage', 'buttonText', 'spinner', 'submitButton']
  
  connect() {
    this.displayPaymentIntent()
  }
  
  async displayPaymentIntent(){
    this.stripe = await loadStripe(this.element.dataset.publishableKey)
    
    const clientSecret = this.element.dataset.clientSecret
  
    const appearance = {
      theme: 'stripe',
    };
    this.elements = this.stripe.elements({ appearance, clientSecret });
  
    const paymentElement = this.elements.create("payment", {options: { fields: {billingDetails: 'never'}}});
    paymentElement.mount("#payment-element");
  }

  async handleSubmit(e) {
    e.preventDefault();
    this.setLoading(true);
    const { error } = await this.stripe.confirmPayment({
      elements: this.elements,
      confirmParams: {
        return_url: this.element.dataset.returnUrl,
      },
    });

    this.showMessage(error.message);
    // if (error.type === "card_error" || error.type === "validation_error") {
    // } else {
    //   this.showMessage("An unexpected error occurred.");
    // }
    // setTimeout(async () => {
    // }, 2000)
  
    this.setLoading(false);
  }

  // ------- UI helpers -------

  showMessage(messageText) {
    const errorMessage = this.errorMessageTarget;

    errorMessage.classList.remove("d-none");
    errorMessage.textContent = messageText;

    setTimeout(function () {
      errorMessage.classList.add("d-none");
      messageText.textContent = "";
    }, 4000);
  }

  // Show a spinner on payment submission
  setLoading(isLoading) {
    console.log(`setting Loading to ${isLoading}`)
    if (isLoading) {
      // Disable the button and show a spinner
      this.buttonTextTarget.textContent = 'Processing...'
      this.buttonTextTarget.classList.add('disabled');
      this.spinnerTarget.classList.remove("d-none");
      this.submitButtonTarget.classList.remove('bg-primary')
      this.submitButtonTarget.classList.add('bg-success')
    } else {
      this.buttonTextTarget.textContent = 'Pay now'
      this.buttonTextTarget.classList.remove('disabled');
      this.spinnerTarget.classList.add("d-none");
      this.submitButtonTarget.classList.add('bg-primary')
      this.submitButtonTarget.classList.remove('bg-success')
    }
  }
}