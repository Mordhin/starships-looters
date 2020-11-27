import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  const typedFiled = document.getElementById("banner-typed-text")
  if (typedFiled) {
    new Typed('#banner-typed-text', {
      strings: ["The best spaceship rent service of the universe!"],
      typeSpeed: 50,
      loop: true,
      fadeOut: true,
      fadeOutDelay: 1,
      showCursor: false
    });
  }
}

export { loadDynamicBannerText };