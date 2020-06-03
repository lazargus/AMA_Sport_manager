import Amadeus from 'amadeus';

const amadeusFlights = () => {
  const flightElement = document.getElementById('flights');
  const amadeus = new Amadeus({
      clientId: flightElement.dataset.amadeusId,
      clientSecret: flightElement.dataset.amadeusSecret
    });
  const flight = JSON.parse(flightElement.dataset.flight);


    amadeus.referenceData.locations.get({
      subType: 'AIRPORT',
      keyword: flight.arrival_city
    }).then(response => {
      const iataCode = response.data[0].iataCode
      amadeus.shopping.flightOffersSearch.get({
        originLocationCode: 'PAR',
        destinationLocationCode: iataCode,
        departureDate: flight.start_date,
        returnDate: flight.end_date,
        adults: 1,
      }).then(response => {
        console.log(response.data.slice(0, 3));
        response.data.slice(0, 3).forEach((offer) => {
          buildCards(offer);
        });
      });
    });
}

const buildCards = (offer) => {
  const flightsResults = document.getElementById('flights_results');
  const timeStart = offer.itineraries[0].segments[0].departure.at.split('T');
  const timeEnd = offer.itineraries[0].segments[0].arrival.at.split('T');
  flightsResults.insertAdjacentHTML('beforeend', `
        <div class="flight-card bg-white p-4 m-2 row text-center" data-controller="expenses">
          <div class="col-md-3">
            <h1><strong>Departure time</strong></h1>
            <div class='flight-date'>
              <p>${timeStart[0]}</p>
              <p>${timeStart[1]}</p>
            </div>
          </div>
          <div class="col-md-3">
            <h1><strong>Flight duration</strong></h1>
            <i class="fas fa-arrow-right"></i>
            <p class='flight-duration'><em>${offer.itineraries[0].duration.replace('PT', '')}</em></p>
          </div>
          <div class="col-md-3 border-right">
            <h1><strong>Arrival time</strong></h1>
            <div class='flight-date'>
              <p>${timeEnd[0]}</p>
              <p>${timeEnd[1]}</p>
            </div>
          </div>
          <div class="col-md-3">
            <h1><strong>Price</strong></h1>
            <p class='mt-3'><strong data-target='expenses.flightPrice'>${offer.price.total}</strong>€</p>
            <button class='add-tournament-btn' data-action='click->expenses#fillFlightForm'>Select</button>
          </div>
        </div>`

    );
}


export { amadeusFlights };
