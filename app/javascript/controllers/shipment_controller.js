import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="shipment"
export default class extends Controller {
  connect () {
  }

  updateShipmentInfo (event) {
    console.log(event.target.value)
  }
}
