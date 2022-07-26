import { Controller } from '@hotwired/stimulus';
export default class extends Controller {
  static targets = ['submit'];
  submittable;

  connect() {
    this.submittable = false;
  }

  updateEditing(event) {
    let edited = false;
    let inputs = this.element.querySelectorAll('input[required]');
    inputs.forEach((input) => {
      edited ||= !!input.value;
    });
    let submittable = edited || event.target.value !== '';
    this.submitTarget.disabled = !submittable;
  }

  // Not working with turbo ajax, need to replace form with turbo stream for now
  // disableFormOnSubmit() {
  //   // this.element
  //   //   .querySelectorAll('input')
  //   //   .forEach((input) => (input.value = null));
  //   this.submitTarget.setAttribute('disabled', 'disabled');
  // }
}
