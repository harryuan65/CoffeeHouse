import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="sign-in-modal"
export default class extends Controller {
  static targets = ['modal']

  connect () {}

  closeModal () {
    this.element.remove()
    // this.element.classList.remove('grid');
    // this.element.classList.add('hidden');
  }
}
