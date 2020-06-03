import { fullcalendar } from "./fullcalendar";

const handleCalendarBug = () => {
  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    if (!document.querySelector(".fc-today-button")) fullcalendar();
  })
}

export { handleCalendarBug };
