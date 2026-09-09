import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => this.dismiss(), 3000)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }

  dismiss() {
    this.element.classList.add("is-leaving")
    this.element.addEventListener("animationend", () => this.element.remove(), { once: true })
    setTimeout(() => this.element.remove(), 400)
  }
}
