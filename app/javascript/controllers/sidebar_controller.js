import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "budget", "budgetCollapse", "earning" ]

  connect() {
    const location = window.location.pathname;
    if (location === "/earnings/new") {
      this.keepEarningOpen()
    }
  }
  keepEarningOpen() {
    this.budgetTarget.setAttribute("aria-expanded", "true");
    console.log(this.budgetCollapseTarget);
    this.budgetCollapseTarget.classList.add("show");
    this.earningTarget.classList.add("active");
  }
}
