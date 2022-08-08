import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ['modal']

  closeModal () {
    this.element.remove()
  }
}
