function render() {
  var url = document.getElementById("ed_source").value;
  loadXML(url, transformXML);
};

function loadXML(url, callback) {
  var xhr = new XMLHttpRequest();
  xhr.open("GET", "res/example.xml", false);
  xhr.send();
  var resp = getXmlString(xhr);

  callback(resp);
};

function getXmlString(xhr) {
  return new XMLSerializer().serializeToString(xhr.responseXML);
}

function transformXML(resp) {
  var xmlTextNode = document.createTextNode(resp);
  document.getElementById("text").appendChild(xmlTextNode);
};
