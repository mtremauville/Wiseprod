import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["name", "category", "price", "image", "previewName", "previewCategory", "previewPrice", "previewImage", "placeholder"]

  connect() {
    this.previewImageTarget.addEventListener("load", () => this.showImage())
    this.previewImageTarget.addEventListener("error", () => this.showPlaceholder())
  }

  update() {
    this.previewNameTarget.textContent = this.nameTarget.value || "Nom du produit"
    this.previewCategoryTarget.textContent = this.categoryTarget.value || "Catégorie"
    this.previewPriceTarget.textContent = this.priceTarget.value ? `${this.priceTarget.value} €` : "0,00 €"

    if (this.imageTarget.value) {
      this.previewImageTarget.src = this.imageTarget.value
    } else {
      this.showPlaceholder()
    }
  }

  showPlaceholder() {
    this.previewImageTarget.style.display = "none"
    this.placeholderTarget.style.display = "flex"
  }

  showImage() {
    this.placeholderTarget.style.display = "none"
    this.previewImageTarget.style.display = "block"
  }
}
