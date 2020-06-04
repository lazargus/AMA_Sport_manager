import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import '@fullcalendar/core/main.css';
import '@fullcalendar/daygrid/main.css';

const eventsTournaments = () => {
  const events = [];
  fetch("/earnings/my_earnings.json")
    .then(response => response.json())
    .then(data => {
      data.forEach((earning) => {
        const event = {
                      title  : earning.tournament.name,
                      start  : earning.tournament.start_date,
                      end    : earning.tournament.end_date,
                      url    : `/earnings/${earning.id}`
                    }
        events.push(event);
      })
      fullcalendar(events);
    });
}

const fullcalendar = (events) => {
const calendarEl = document.getElementById('calendar');
  const calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin ],
    header: {
      left: 'prev,next today',
      center: 'title',
      right: ''
    },
    aspectRatio: 1,
    height: "parent",
    events : events,
    eventClick: function(info) {
      if (info.event.url) {
      window.open(info.event.url, "_self");
      }
    }
  });

  calendar.getEvents();
  calendar.render();
};


export { eventsTournaments };
