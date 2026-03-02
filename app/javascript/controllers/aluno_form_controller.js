import { Controller } from "@hotwired/stimulus"

// Validates RA field format in real-time and provides instant feedback
export default class extends Controller {
  static targets = ["raInput", "raHint"]

  connect() {
    // Auto-uppercase on connect if there's a value
    if (this.hasRaInputTarget && this.raInputTarget.value) {
      this.raInputTarget.value = this.raInputTarget.value.toUpperCase()
    }
  }

  validateRa() {
    const input = this.raInputTarget
    const hint = this.hasRaHintTarget ? this.raHintTarget : null
    const value = input.value.toUpperCase()

    // Auto-uppercase
    input.value = value

    if (!hint) return

    if (value === "") {
      // Empty — show default hint
      hint.textContent = "Formato: uma letra seguida de números (ex: N874321)"
      hint.className = "mt-1.5 text-xs text-slate-500"
      input.classList.remove("border-emerald-400", "ring-emerald-100", "border-rose-400", "ring-rose-100")
      input.classList.add("border-slate-300/80")
      return
    }

    const isValid = /^[A-Z]\d+$/.test(value)
    const isPartial = /^[A-Z]$/.test(value) // just the letter so far

    if (isValid) {
      hint.textContent = "✓ Formato válido"
      hint.className = "mt-1.5 text-xs text-emerald-600 font-medium"
      input.classList.remove("border-slate-300/80", "border-rose-400", "ring-rose-100")
      input.classList.add("border-emerald-400", "ring-emerald-100")
    } else if (isPartial) {
      hint.textContent = "Continue digitando os números..."
      hint.className = "mt-1.5 text-xs text-amber-600"
      input.classList.remove("border-slate-300/80", "border-emerald-400", "ring-emerald-100", "border-rose-400", "ring-rose-100")
    } else {
      hint.textContent = "Formato inválido — use uma letra seguida de números (ex: N874321)"
      hint.className = "mt-1.5 text-xs text-rose-600 font-medium"
      input.classList.remove("border-slate-300/80", "border-emerald-400", "ring-emerald-100")
      input.classList.add("border-rose-400", "ring-rose-100")
    }
  }
}
