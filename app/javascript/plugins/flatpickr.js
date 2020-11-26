import flatpickr from "flatpickr";


const flatpickrCalendar = () => {
  flatpickr(".datepicker", {
    mode: "range",
    minDate: "today",
    conjunction: " and ",
    defaultDate: ["today", new Date().fp_incr(7)]
  });
};

export { flatpickrCalendar };
