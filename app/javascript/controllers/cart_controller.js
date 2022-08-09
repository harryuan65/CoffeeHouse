import NumberFieldController from './number_field_controller'

// Connects to data-controller="cart"
export default class extends NumberFieldController {
  connect () {
  }

  incrementItem () {
    this.updateAmount(this.increment())
  }

  decrementItem () {
    this.updateAmount(this.decrement())
  }

  updateAmount (newAmount) {
    // Should we update db?
    const priceElement = this.element.querySelector('[data-name="price"]')
    const priceText = priceElement.innerHTML.replace(/NT\$/, '')
    const price = Number(priceText)
    const newPrice = this.numberWithCommas(price * newAmount)
    const subtotalElement = this.element.querySelector('[data-name="subtotal"]')
    subtotalElement.innerHTML = `NT$ ${newPrice}`
  }
}
