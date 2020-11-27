const updateStatusClass = () => {
  const statuses = document.querySelectorAll('.status');
  if (statuses) {
    statuses.forEach(status => {
      const statusText = status.innerText;
      status.parentElement.classList.add(statusText.toLowerCase());
    });

  }
};

export { updateStatusClass };
