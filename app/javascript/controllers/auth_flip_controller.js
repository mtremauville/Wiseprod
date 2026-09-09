import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.classList.add("flip-in")
  }

  intercept(event) {
    const link = event.target.closest("a")
    if (!link || link.target === "_blank") return

    event.preventDefault()

    const reduceMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches
    if (reduceMotion) {
      window.location.href = link.href
      return
    }

    this.element.classList.add("flip-out")
    this.element.addEventListener("animationend", () => {
      window.location.href = link.href
    }, { once: true })
  }
}
