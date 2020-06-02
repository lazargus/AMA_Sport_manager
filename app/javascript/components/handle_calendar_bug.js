import { fullcalendar } from "./fullcalendar";

const handleCalendarBug = () => {
  // const prevBtn = document.querySelector('.fc-prev-button');
  // const nextBtn = document.querySelector('.fc-next-button');
  $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
    // prevBtn.click();
    // nextBtn.click();
    fullcalendar();
  })
}

export { handleCalendarBug };
