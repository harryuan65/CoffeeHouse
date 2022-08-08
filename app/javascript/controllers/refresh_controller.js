import { Controller } from '@hotwired/stimulus'
import { Turbo } from '@hotwired/turbo-rails'

// Allows partial post,delete links/forms to refresh the page content
// Other controller can inherit from this and call attach in connect to refresh after turbo event
// Connects to data-controller="refresh"
export default class extends Controller {
  connect () {
    this.refreshOn('turbo:submit-end')
  }

  refreshOn (eventName) {
    this.element.addEventListener(eventName, this.refresh)
  }

  refresh (event) {
    if (event.detail.success) {
      Turbo.visit(window.location.href)
    }
  }
}
