import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["content"]

  connect() {
  }

  toggle(event) {
    event.preventDefault()
    const content = this.contentTarget
    content.style.display = content.style.display === "none" ? "block" : "none"
  }
}
