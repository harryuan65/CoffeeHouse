import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="payment-select"
export default class extends Controller {
  connect () {
  }

  get paymentField () {
    return this.element.querySelector('input[type=text]')
  }

  // When clicked on a image, will set the value of payment_method field.
  pick (event) {
    const targetValue = event.target.dataset.value
    // remove all img highlight classes
    this.element.querySelectorAll('img').forEach(e => e.classList.remove('border-2', 'border-slate-400'))
    // add highlight to selected one
    event.target.classList.add('border-2', 'border-slate-400')
    this.paymentField.value = targetValue
  }
}
