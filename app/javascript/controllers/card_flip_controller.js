import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["inner"]

  flip(event) {
    event.preventDefault()
    this.innerTarget.classList.toggle("is-flipped")
  }
}
