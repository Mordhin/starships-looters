const displayShipDetails = () => {
  const ssDetails = document.getElementById("ss-show-details");

  if (ssDetails) {
    ssDetails.addEventListener("click", () => {
      document.getElementById("ss-ship-details").classList.toggle("d-none")
    });
  }
};

export { displayShipDetails };
