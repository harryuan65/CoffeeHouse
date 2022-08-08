import { Controller } from '@hotwired/stimulus'
// import { Turbo } from '@hotwired/turbo-rails'

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ['modal']

  connect () {
    this.element.addEventListener('turbo:submit-end', this.next)
  }

  next (event) {
    console.log(event.detail)
    // if (event.detail.success) {
    //   Turbo.visit(event.detail.fetchResponse.response.url)
    // }
  }

  closeModal () {
    this.element.remove()
  }
}
