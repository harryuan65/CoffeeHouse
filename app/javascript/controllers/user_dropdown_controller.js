import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="user-dropdown"
export default class extends Controller {
  connect () {
    document.addEventListener('click', this.clickedOutside)
  }

  disconnect () {
    document.removeEventListener('click', this.clickedOutside)
  }

  get dropdown () {
    return this.element.querySelector('ul')
  }

  clickedOutside = (event) => {
    const target = event.target
    // So clicking away will add hidden to ul
    if (!this.element.contains(target)) {
      this.dropdown.classList.add('hidden')
    }
  }

  toggle () {
    this.dropdown.classList.toggle('hidden')
  }
}
