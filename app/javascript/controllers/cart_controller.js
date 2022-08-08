import NumberFieldController from './number_field_controller'

// Connects to data-controller="cart"
export default class extends NumberFieldController {
  connect () {
  }

  incrementItem () {
    console.log('incrementItem')
    const priceElement = this.element.previousElementSibling
    const priceText = priceElement.innerHTML.replace(/NT\$/, '')
    const price = Number(priceText)
    const currentAmount = this.increment()
    const newPrice = this.numberWithCommas(price * currentAmount)
    this.element.nextElementSibling.innerHTML = `NT$ ${newPrice}`
  }

  decrementItem () {
    console.log('decrementItem')
    const priceElement = this.element.previousElementSibling
    const priceText = priceElement.innerHTML.replace(/NT\$/, '')
    const price = Number(priceText)
    const currentAmount = this.decrement()
    const newPrice = this.numberWithCommas(price * currentAmount)
    this.element.nextElementSibling.innerHTML = `NT$ ${newPrice}`
  }
}
