import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="number-field"
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
    return this.amountTarget.value
  }

  decrement () {
    const currentValue = Number(this.amountTarget.value)
    const minValue = Number(this.amountTarget.min)
    if (currentValue > minValue) {
      this.amountTarget.value = currentValue - 1
    }
    return this.amountTarget.value
  }

  numberWithCommas (number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')
  }
}
