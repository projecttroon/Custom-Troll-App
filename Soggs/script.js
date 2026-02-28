fetch("https://ipwho.is/")
  .then(response => response.json())
  .then(data => {
    if (data.success) {
      document.getElementById("ip").textContent = data.ip;
      document.getElementById("country").textContent = data.country;
      document.getElementById("city").textContent = data.city;
    } else {
      setError();
    }
  })
  .catch(() => {
    setError();
  });

function setError() {
  document.getElementById("ip").textContent = "Unknown";
  document.getElementById("country").textContent = "Unknown";
  document.getElementById("city").textContent = "Unknown";
}
