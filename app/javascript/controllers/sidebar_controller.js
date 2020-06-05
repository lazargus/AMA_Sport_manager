import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "earnings", "tournaments", "earning", "expense", "dashboard" ]

  connect() {
    const location = window.location.pathname;
    if (location.includes("/earnings/new")) {
      this.keepEarningOpen()
    }
    else if (location.includes("/expenses/new")) {
      this.keepExpenseOpen()
    }
    else if (location.includes("/dashboard")) {
      this.keepDashboardOpen()
    }
    else if (location.includes("/earnings")) {
      this.keepEarningsOpen()
    }
    else if (location.includes("/tournaments")) {
      this.keepTournamentsOpen()
    }
  }
  keepEarningOpen() {
    this.earningTarget.classList.add("active");
  }
  keepExpenseOpen() {
    this.expenseTarget.classList.add("active");
  }
  keepDashboardOpen() {
    this.dashboardTarget.classList.add("active");
  }
  keepEarningsOpen() {
    this.earningsTarget.classList.add("active");
  }
  keepTournamentsOpen() {
    this.tournamentsTarget.classList.add("active");
  }

}
