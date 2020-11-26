const footerScroll = () => {
  const show = document.getElementById("show");

  if (show) {
    const footer = document.querySelector(".footer");
    footer.classList.add("sticky");
  }
};

export  { footerScroll }