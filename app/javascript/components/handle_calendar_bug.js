import { eventsTournaments } from "./fullcalendar";

const handleCalendarBug = () => {
  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    if (!document.querySelector(".fc-today-button")) eventsTournaments();
  })
}

export { handleCalendarBug };
