
fetch("./psalms-23-traditional-sample.json")
  .then(response => {
    if (!response.ok) throw new Error("Bible sample not found");
    return response.json();
  })
  .then(data => {
    textData = { ...textData, ...data };
    if (!document.querySelector("#reader").hidden) {
      renderChapter();
    }
  })
  .catch(error => console.log("Bible text:", error.message));
