import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import '@fullcalendar/core/main.css';
import '@fullcalendar/daygrid/main.css';

const getEvents = () => {
  const tournamentCards = document.querySelectorAll('.my-tournaments');
  const events = [...tournamentCards].map(card => {
    return {
      title:card.dataset.tournamentName,
      start:card.dataset.startDate,
      end:card.dataset.endDate
    }
  });
  return events;
}

const fullcalendar = () => {
  const calendarEl = document.getElementById('calendar');

  const calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin ],
    events: getEvents(),
    eventClick: function(info) {
      const modal = document.getElementById("myModal");
      const close = document.querySelector(".close");
      modal.style.display = "block";
      close.addEventListener("click", (e) => {
        modal.style.display = "none";
      });
    }

  });
  calendar.render();
  calendar.getEvents();
}

export { fullcalendar };
