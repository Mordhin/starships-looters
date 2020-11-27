const updateStatusClass = () => {
  const statuses = document.querySelectorAll('.status');
  console.log(statuses);
  if (statuses) {
    statuses.forEach(status => {
      const statusText = status.innerText;
      console.log(statusText);
      status.parentElement.classList.add(statusText.toLowerCase());
    });

  }
};

export { updateStatusClass };
