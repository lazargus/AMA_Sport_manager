import $ from 'jquery';
import 'select2';


const initSelect2 = () => {
  $('.select2').select2({
    minimumResultsForSearch: -1,
    width: "100%",
    height: "50px",
    placeholder: "Select a choice",
  });
}

export { initSelect2 };
