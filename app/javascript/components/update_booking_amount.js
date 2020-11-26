const updateBookingAmount = () => {
  const submitBtn = document.getElementById("booking_submit");
  const calendar = document.querySelector(".datepicker");
  const pricePerDay = document.querySelector("#price-per-day").innerText;
  let startDate = Date.parse(document.querySelector('.datepicker').value.substring(0,10));
  let endDate = Date.parse(document.querySelector('.datepicker').value.substring(14));
  let totalDays = (endDate - startDate) / 86400000;
  let price = parseInt(pricePerDay,10) * parseInt(totalDays, 10);
  console.log(totalDays);
  console.log(pricePerDay);
  console.log(price);
  if (calendar) {
    calendar.addEventListener("change", () => {
      startDate = Date.parse(document.querySelector('.datepicker').value.substring(0,10));
      endDate = Date.parse(document.querySelector('.datepicker').value.substring(14));
      totalDays = (endDate - startDate) / 86400000;
      price = parseInt(pricePerDay,10) * parseInt(totalDays, 10);
      if (document.querySelector('.datepicker').value.length > 10) {
        document.getElementById("booking_submit").value = `Book for ${totalDays} day(s) and ${price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")} ₹`
      }
    });
  };
};

export { updateBookingAmount };
