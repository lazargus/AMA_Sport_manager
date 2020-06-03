import { fullcalendar } from "./fullcalendar";

const handleCalendarBug = () => {
  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    fullcalendar();
  })
}

export { handleCalendarBug };
