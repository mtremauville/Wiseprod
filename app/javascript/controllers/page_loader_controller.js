import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay"]

  show(event) {
    const url = event.detail?.url
    if (url && /\/products\/\d+/.test(new URL(url).pathname)) {
      this.overlayTarget.classList.add("is-visible")
    }
  }

  hide() {
    this.overlayTarget.classList.remove("is-visible")
  }
}
