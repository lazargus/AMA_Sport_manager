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
        <div class="flight-card bg-white rounded p-4 m-2 row text-center">
          <div class="col-md-3">
            <p><strong>Heure de depart</strong></p>
            <p>${timeStart[0]}</p>
            <p>${timeStart[1]}</p>
          </div>
          <div class="col-md-3">
            <p><strong>Durée du vol</strong></p>
            <p><hr></p>
            <p>${offer.itineraries[0].duration.replace('PT', '')}</p>
          </div>
          <div class="col-md-3 border-right">
            <p><strong>Heure d'arrivée</strong></p>
            <p>${timeEnd[0]}</p>
            <p>${timeEnd[1]}</p>
          </div>
          <div class="col-md-3">
            <p><strong>Prix</strong></p>
            <p>${offer.price.total} ${offer.price.currency}</p>
          </div>
        </div>`

    );
}


export { amadeusFlights };
