import { Turbo } from '@hotwired/turbo-rails'
import NumberFieldController from './number_field_controller'

// Connects to data-controller="cart"
export default class extends NumberFieldController {
  static targets = ['amount', 'increment', 'decrement']
  connect () {
  }

  incrementItem () {
    const [changed, newAmount] = this.increment()
    if (changed) {
      this.updateAmount(newAmount)
    }
  }

  decrementItem () {
    const [changed, newAmount] = this.decrement()
    if (changed) {
      this.updateAmount(newAmount)
    }
  }

  updateAmount (newAmount) {
    this.#disableButtons()
    this.#disableAmountInput()
    const matchData = this.element.id.match(/cart_item_([-0-9a-f]+)/)
    const id = matchData[1]
    fetch(`/cart_items/${id}`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        Accepts: 'text/vnd.turbo_stream.html',
        'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").content,
      },
      body: JSON.stringify({
        amount: newAmount,
      }),
      credentials: 'same-origin',
    }).then(res => res.text())
      .then(html => Turbo.renderStreamMessage(html))
  }

  // In case the internet is slow
  #disableButtons () {
    this.incrementTarget.disabled = 'disabled'
    this.decrementTarget.disabled = 'disabled'
  }

  #disableAmountInput () {
    this.amountTarget.disabled = 'disabled'
  }
}
