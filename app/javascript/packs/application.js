// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import "../plugins/flatpickr"
import "controllers"


// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';
import { tournamentsCardsHover } from "../components/tournaments_cards_hover";

import { initMapbox } from "../plugins/init_mapbox";
import { amadeusFlights } from "../plugins/amadeus_flights";

import { tournamentShowPrizeMoney } from "../components/tournament_show_prize_money";
import { fullcalendar } from "../components/fullcalendar";
import { handleCalendarBug } from "../components/handle_calendar_bug";
import { buildChart } from "../components/chart";
import { handleMapBug } from "../components/handle_map_bug";



document.addEventListener('turbolinks:load', () => {
  // Call your functions here, e.g:
  // initSelect2();
  if (document.getElementById('calendar')) {
    handleCalendarBug();
  }
  if (document.querySelector('#map')) {
    handleMapBug();
  }
  tournamentsCardsHover();
  buildChart();
  amadeusFlights();
});

tournamentShowPrizeMoney();

