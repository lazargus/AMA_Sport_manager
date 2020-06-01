import mapboxgl from 'mapbox-gl';
import Amadeus from 'amadeus';

const fitMapToMarkers = (map, marker) => {
  const bounds = new mapboxgl.LngLatBounds();
  bounds.extend([ marker.lng, marker.lat ]);
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};


const initMapbox = () => {
  const mapElement = document.getElementById('map');
  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });
    const marker = JSON.parse(mapElement.dataset.markers);
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(map);
    // const hotelsMarkers = initAmadeus();
    // hotelsMarkers.forEach((marker) => {
    //   new mapboxgl.Marker()
    //   .setLngLat([ body[:data][:hotel][:longitude], body[:data][:hotel][:latitude] ])
    //   .addTo(map);
    // });
    fitMapToMarkers(map, marker);
  }
};

const initAmadeus = () => {
  const mapElement = document.getElementById('map');
  const amadeus = new Amadeus({
    clientId: mapElement.dataset.amadeusId,
    clientSecret: mapElement.dataset.amadeusSecret
  });
  const marker = JSON.parse(mapElement.dataset.markers);
  amadeus.shopping.hotelOffers.get({
    latitude: marker.lat,
    longitude: marker.lng,
    radius: 3,
    radiusUnit: 'KM',
  }).then(response => console.log(response));
};

export { initMapbox };
