import Amadeus from 'amadeus';

const amadeusFlights = () => {
  const flightElement = document.getElementById('flights');
  const amadeus = new Amadeus({
      clientId: flightElement.dataset.amadeusId,
      clientSecret: flightElement.dataset.amadeusSecret
    });
  const flight = JSON.parse(flightElement.dataset.flight);
  amadeus.shopping.flightOffersSearch.get({
    originLocationCode: 'PAR',
    destinationLocationCode: flight.arrival_city,
    departureDate: flight.start_date,
    returnDate: flight.end_date,
    adults: 1,
  }).then(response => (response.data));
  console.log(response);
}


export { amadeusFlights };
