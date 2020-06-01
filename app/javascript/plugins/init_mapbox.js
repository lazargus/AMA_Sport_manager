import mapboxgl from 'mapbox-gl';
import Amadeus from 'amadeus';

const fitMapToMarkers = (map, marker) => {
  const bounds = new mapboxgl.LngLatBounds();
  bounds.extend([ marker.lng, marker.lat ]);
  map.fitBounds(bounds, { padding: 70, maxZoom: 13, duration: 0 });
};


const initMapbox = () => {
  const mapElement = document.getElementById('map');
  const amadeus = new Amadeus({
    clientId: mapElement.dataset.amadeusId,
    clientSecret: mapElement.dataset.amadeusSecret
  });
  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    const marker = JSON.parse(mapElement.dataset.marker);
    amadeus.shopping.hotelOffers.get({
      latitude: marker.lat,
      longitude: marker.lng,
      radius: 3,
      radiusUnit: 'KM',
    }).then(response => response.data.forEach((result) => {
      console.log(response);
      const infoWindow = `<div class='card'>
                            <div class='window-image'></div>
                            <div class='details'>
                              <ul><li>${result.hotel.name}</li>
                              <li>${result.hotel.hotelDistance.distance}km from the stadium</li>
                              <li>${result.hotel.rating}/5</li>
                              <li>${result.offers[0].price.total} ${result.offers[0].price.currency} per night</li>
                              </ul>
                            </div>
                          </div>`
      const popup = new mapboxgl.Popup().setHTML(infoWindow);
      new mapboxgl.Marker()
      .setLngLat([ result.hotel.longitude, result.hotel.latitude ])
      .setPopup(popup)
      .addTo(map);
    }));
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(map);
    fitMapToMarkers(map, marker);
  }
};


export { initMapbox };
