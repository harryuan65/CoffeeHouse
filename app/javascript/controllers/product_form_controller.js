import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="product-form"
export default class extends Controller {
  static targets = ['amount']

  connect () {
  }

  increment () {
    const currentValue = Number(this.amountTarget.value)
    const maxValue = Number(this.amountTarget.max)
    if (currentValue < maxValue) {
      this.amountTarget.value = currentValue + 1
    }
  }

  decrement () {
    const currentValue = Number(this.amountTarget.value)
    const minValue = Number(this.amountTarget.min)
    if (currentValue > minValue) {
      this.amountTarget.value = currentValue - 1
    }
  }
}
