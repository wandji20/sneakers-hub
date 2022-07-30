import { Controller } from "stimulus"
import {loadStripe} from '@stripe/stripe-js';

export default class extends Controller {
  connect() {
    this.checkStatus()
    this.displayPaymentIntent()
  }
  
  async displayPaymentIntent(){
    this.stripe = await loadStripe(this.element.dataset.publishableKey)
    
    const clientSecret = this.element.dataset.clientSecret
  
    const appearance = {
      theme: 'stripe',
    };
    this.elements = this.stripe.elements({ appearance, clientSecret });
  
    const paymentElement = this.elements.create("payment");
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

    if (error.type === "card_error" || error.type === "validation_error") {
      this.showMessage(error.message);
    } else {
      this.showMessage("An unexpected error occurred.");
    }
  
    this.setLoading(false);
  }

    // Fetches the payment intent status after payment submission
  async checkStatus() {
    const clientSecret = new URLSearchParams(window.location.search).get(
      "payment_intent_client_secret"
    );

    if (!clientSecret) {
      return;
    }

    const { paymentIntent } = await this.stripe.retrievePaymentIntent(clientSecret);

    switch (paymentIntent.status) {
      case "succeeded":
        this.showMessage("Payment succeeded!");
        break;
      case "processing":
        this.showMessage("Your payment is processing.");
        break;
      case "requires_payment_method":
        this.showMessage("Your payment was not successful, please try again.");
        break;
      default:
        this.showMessage("Something went wrong.");
        break;
    }
  }

  // ------- UI helpers -------

  showMessage(messageText) {
    const messageContainer = document.querySelector("#payment-message");

    messageContainer.classList.remove("hidden");
    messageContainer.textContent = messageText;

    setTimeout(function () {
      messageContainer.classList.add("hidden");
      messageText.textContent = "";
    }, 4000);
  }

  // Show a spinner on payment submission
  setLoading(isLoading) {
    if (isLoading) {
      // Disable the button and show a spinner
      document.querySelector("#submit").disabled = true;
      document.querySelector("#spinner").classList.remove("hidden");
      document.querySelector("#button-text").classList.add("hidden");
    } else {
      document.querySelector("#submit").disabled = false;
      document.querySelector("#spinner").classList.add("hidden");
      document.querySelector("#button-text").classList.remove("hidden");
    }
    
    

  }
}