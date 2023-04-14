fetch('https://k2e7mffpi3.execute-api.ca-central-1.amazonaws.com/ResumeSiteCounter')
    .then(res => {
      return res.json();
    })
    .then(data => {
      console.log(data);

      const hitcount = data.count;
      const hitdiv = document.getElementById("hitcounter");
      const newdiv = document.createElement("div");

      newdiv.innerHTML = "Site views: " + hitcount;
      hitdiv.appendChild(newdiv);


    })
    .catch(error => console.log(error));