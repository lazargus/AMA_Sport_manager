import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import '@fullcalendar/core/main.css';
import '@fullcalendar/daygrid/main.css';

const eventsTournaments = () => {
  const tournaments = document.querySelectorAll(".my-tournament-card");
  const events = [];
  const tournamentsEvent = tournaments.forEach((tournament) => {
     const event ={
                    title  : tournament.dataset.name,
                    start  : tournament.dataset.startDate,
                    end    : tournament.dataset.endDate,
                    url    : tournament.dataset.url,
                  }
    events.push(event);
  })
  return events;
}

const fullcalendar = () => {
const calendarEl = document.getElementById('calendar');

  const calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin ],
    aspectRatio: 1,
    height: "parent",
    events : eventsTournaments(),
    eventClick: function(info) {
      if (info.event.url) {
      window.open(info.event.url, "_self");
      }
    }
  });

  calendar.getEvents();
  calendar.render();
};


export { fullcalendar };
