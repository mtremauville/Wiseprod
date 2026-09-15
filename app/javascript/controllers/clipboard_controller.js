import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "label"]

  async copy() {
    const text = this.sourceTarget.textContent.trim()

    try {
      await navigator.clipboard.writeText(text)
      this.flash("Copié !")
    } catch (error) {
      this.flash("Copie impossible")
    }
  }

  flash(message) {
    if (!this.hasLabelTarget) return

    const original = this.labelTarget.textContent
    this.labelTarget.textContent = message
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.labelTarget.textContent = original
    }, 1500)
  }
}
