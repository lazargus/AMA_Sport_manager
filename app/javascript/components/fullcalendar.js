import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import '@fullcalendar/core/main.css';
import '@fullcalendar/daygrid/main.css';


const fullcalendar = () => {

    const calendarEl = document.getElementById('calendar');

    const calendar = new Calendar(calendarEl, {
      plugins: [ dayGridPlugin ]
    });
    console.log("hello")
    calendar.render();
}



export { fullcalendar };
