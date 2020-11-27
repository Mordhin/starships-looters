const footerScroll = () => {
  const footerPage = document.getElementById("footer-page")

  if (footerPage) {
    const navbar = document.querySelector(".footer");
    navbar.classList.add("footer-fix");
    window.addEventListener("scroll", () => {
      navbar.classList.toggle("scrolled", window.scrollY > window.innerHeight);
    });
  }
};

export  { footerScroll }