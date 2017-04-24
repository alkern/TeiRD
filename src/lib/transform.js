function render() {
  var url = document.getElementById("ed_source").value;

  xml = loadXML("res/example.xml");
  xsl = loadXML("res/example.xsl");

  xsltProcessor = new XSLTProcessor();
  xsltProcessor.importStylesheet(xsl);
  result = xsltProcessor.transformToFragment(xml, document);
  document.getElementById("text").appendChild(result);
};

function loadXML(url) {
  var xhr = new XMLHttpRequest();
  xhr.open("GET", url, false);
  xhr.send();
  return xhr.responseXML;
};
