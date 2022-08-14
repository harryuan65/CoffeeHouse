import { Controller } from '@hotwired/stimulus'
import { Turbo } from '@hotwired/turbo-rails'

// Connects to data-controller="shipment"
export default class extends Controller {
  connect () {
  }

  updateShipmentInfo (event) {
    const code = event.target.value
    const url = new URL(window.location.origin + '/shipments/new')
    url.searchParams.set('shipment[region][code]', code)
    fetch(url, {
      headers: {
        Accept: 'text/vnd.turbo-stream.html',
      },
      credentials: 'same-origin',
    })
      .then(r => r.text())
      .then(html => Turbo.renderStreamMessage(html))
  }
}
