import { Controller } from '@hotwired/stimulus'
export default class extends Controller {
  static targets = ['submit']
  submittable

  connect () {
    this.submittable = false
  }

  updateEditing (event) {
    let allEdited = true
    const inputs = this.element.querySelectorAll('input[required]')
    inputs.forEach((input, i) => {
      allEdited &&= !!input.value
    })
    const submittable = allEdited && !!event.target.value
    this.submitTarget.disabled = !submittable
  }

  // Not working with turbo ajax, need to replace form with turbo stream for now
  // disableFormOnSubmit() {
  //   // this.element
  //   //   .querySelectorAll('input')
  //   //   .forEach((input) => (input.value = null));
  //   this.submitTarget.setAttribute('disabled', 'disabled');
  // }
}
