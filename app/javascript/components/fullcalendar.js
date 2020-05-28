import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import '@fullcalendar/core/main.css';
import '@fullcalendar/daygrid/main.css';

// const getEvents = () => {
//   const tournamentCards = document.querySelectorAll('.calendar');
//   const events = [...tournamentCards].map(card => {
//     return {
//       id:card.dataset.id,
//       title:card.dataset.tournamentName,
//       start:card.dataset.startDate,
//       end:card.dataset.endDate
//     }
//   });
//   return events;
// }

// const fetchTournament = (tournamentId) => {
//   fetch(`/tournaments/${tournamentId}`,{
//     headers: {
//       "Accept": "application/json"
//     }
//   })
//   .then(response => response.json())
//   .then((data) => {


//     return data.attachmentPartial;
//   });
// }


const fullcalendar = () => {
  const calendarEl = document.getElementById('calendar');
  const tournaments = JSON.parse(calendarEl.dataset.tournaments);
  const calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin ],
    events: tournaments,
    eventClick: function(info) {
      const modal = document.getElementById("myModal");
      const modalContainer = modal.querySelector(".modal-content");
      fetch(`/tournaments/${info.event.id}`,{
        headers: {
          "Accept": "application/json"
        }
      })
      .then(response => response.json())
      .then((data) => {
        modalContainer.innerHTML = data.attachmentPartial;
      });
      modal.style.display = "block";
      const close = document.querySelector(".close");
      close.addEventListener("click", (e) => {
        modal.style.display = "none";
        console.log(info);
      });
    }
  });
  calendar.render();
  calendar.getEvents();
}

export { fullcalendar };
