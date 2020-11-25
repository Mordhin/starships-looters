const navbarScroll = () => {
  const home = document.getElementById("home")

  if (home) {
    const navbar = document.querySelector(".navbar-lewagon");
    navbar.classList.add("navbar-home");
    window.addEventListener("scroll", () => {
      navbar.classList.toggle("scrolled", window.scrollY > window.innerHeight);
    });
  }
};

export  { navbarScroll }