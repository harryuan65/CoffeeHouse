import RefreshController from './refresh_controller'

export default class extends RefreshController {
  static targets = ['submit']
  submittable

  connect () {
    this.submittable = false
    this.refreshOn('turbo:submit-end')
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
}
