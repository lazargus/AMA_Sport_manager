// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "hotel", "hotelPrice", 'flightPrice' ]

  fillHotelForm() {
    const amount = document.getElementById(`HotelAmount`);
    const description = document.getElementById(`HotelDesc`);
    const duration = Number.parseInt(document.getElementById('map').dataset.duration);
    const amountValue = Number.parseInt(this.hotelPriceTarget.innerText) * duration;
    const descriptionValue = `${duration} days at ${this.hotelTarget.innerText}`;
    amount.value = amountValue;
    description.value = descriptionValue
    this.fillHotelInfo(descriptionValue, amountValue)
  }

  fillFlightForm() {
    const amount = document.getElementById(`FlightAmount`);
    const amountValue = Number.parseInt(this.flightPriceTarget.innerText);
    console.log(amount.value);
    amount.value = amountValue;
    console.log(amount.value);
    this.fillFlightInfo(amountValue)
  }

  fillHotelInfo(description, price) {
    const hotelCard = document.getElementById('hotel-card');
    hotelCard.insertAdjacentHTML('beforeend',`
      <div class='d-flex justify-content-between'>
        <p>${description}</p>
        <p><strong>$${price}</strong></p>
      </div>
      `)
  }

  fillFlightInfo(price) {
    const flightCard = document.getElementById('flight-card');
    flightCard.insertAdjacentHTML('beforeend', `
      <div class='d-flex justify-content-between'>
        <p>Flight to the tournament city</p>
        <p><strong>$${price}</strong></p>
      </div>
      `)

  }
}
