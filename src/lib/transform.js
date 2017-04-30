function ex_short() {
  xml = loadXML("res/example_short.xml");
  xsl = loadXML("res/example_short.xsl");

  render(xml, xsl);
}

function ex_long() {
  xml = loadXML("res/example_long.xml");
  xsl = loadXML("res/example_long.xsl");

  render(xml, xsl);
}

function render(xml, xsl) {
  //var url = document.getElementById("ed_source").value;
  xsltProcessor = new XSLTProcessor();
  xsltProcessor.importStylesheet(xsl);
  result = xsltProcessor.transformToDocument(xml, document);
  //document.getElementById("text").appendChild(result);
  var serializer = new XMLSerializer();
  var transformed = serializer.serializeToString(result.documentElement);
  var newwindow = window.open();
  newwindow.document.open();
  newwindow.document.write(transformed);
  newwindow.document.close();
};

function loadXML(url) {
  var xhr = new XMLHttpRequest();
  xhr.open("GET", url, false);
  xhr.send();
  return xhr.responseXML;
};
